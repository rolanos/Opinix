import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/dto/create_question/create_question_response.dart';
import 'package:statistika_mobile/core/repository/available_answer_repository.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/form/domain/enum/question_types.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

import '../../../../core/dto/create_available_answer/create_available_answer_request.dart';
import '../../../../core/dto/create_question/create_question_request.dart';
import '../../../../core/repository/question_repository.dart';

part 'create_question_state.dart';

class CreateQuestionCubit extends Cubit<CreateQuestionState> {
  CreateQuestionCubit() : super(CreateQuestionEmpty());

  void init(String? typeId) {
    if (typeId != null && QuestionTypes.tryParse(typeId) != null) {
      emit(
        CreateQuestionInitial(
          question: Question.empty().copyWith(typeId: typeId),
        ),
      );
    } else {
      emit(
        CreateQuestionError(
          message: 'Данный тип вопросов находится в разработке',
        ),
      );
    }
  }

  void changeQuestionTitle(String title) {
    final state = this.state;
    if (state is CreateQuestionInitial) {
      emit(state.copyWith(question: state.question.copyWith(title: title)));
    }
  }

  void addAnswer() {
    final state = this.state;
    if (state is CreateQuestionInitial) {
      int max = state.question.availableAnswers.isNotEmpty
          ? int.tryParse(state.question.availableAnswers[0].id) ?? 0
          : 0; // начальное значение

      for (var numStr in state.question.availableAnswers) {
        int current = int.tryParse(numStr.id) ?? 0;
        if (current > max) {
          max = current;
        }
      }

      max++;
      final newAnswer = AvailableAnswer.empty().copyWith(
        id: max.toString(),
      );
      final copyAnswers =
          List<AvailableAnswer>.from(state.question.availableAnswers)
            ..add(newAnswer);
      emit(
        state.copyWith(
          question: state.question.copyWith(
            availableAnswers: copyAnswers,
          ),
        ),
      );
    }
  }

  void updateAnswer(AvailableAnswer answer, String text) {
    final state = this.state;
    if (state is CreateQuestionInitial) {
      final copy = List<AvailableAnswer>.from(state.question.availableAnswers);
      final index = copy.indexWhere(
        (elem) => answer.id == elem.id,
      );
      if (index != -1) {
        copy[index] = copy[index].copyWith(text: text);
        emit(
          state.copyWith(
            question: state.question.copyWith(
              availableAnswers: copy,
            ),
          ),
        );
      }
    }
  }

  void deleteAnswer(AvailableAnswer answer) {
    final state = this.state;
    if (state is CreateQuestionInitial) {
      final copyAnswers =
          List<AvailableAnswer>.from(state.question.availableAnswers)
            ..removeWhere(
              (elem) => elem.id == answer.id,
            );
      emit(
        state.copyWith(
          question: state.question.copyWith(
            availableAnswers: copyAnswers,
          ),
        ),
      );
    }
  }

  bool canCreateQuestion() {
    final state = this.state;
    if (state is CreateQuestionInitial) {
      return state.question.availableAnswers.isNotEmpty &&
          state.question.title.isNotEmpty;
    }
    return false;
  }

  //Добавляем новый вопрос в список вопросов
  Future<void> addNewQuestion() async {
    final state = this.state;
    if (state is CreateQuestionInitial) {
      emit(CreateQuestionSendLoading(question: state.question));

      final createRequest = CreateQuestionRequest(
        title: state.question.title,
        pastQuestion: null,
        nextQuestion: null,
        typeId: state.question.typeId ?? '',
        sectionId: null,
        isGeneral: true,
        userId: await SharedPreferencesManager.getUserId(),
      );
      final result = await QuestionRepository().createQuestion(createRequest);

      result.match(
        (e) {
          emit(CreateQuestionError(message: e.toString()));
          emit(state);
        },
        (q) async {
          var errors = 0;
          for (var availableAnswer in state.question.availableAnswers) {
            final createAnswerRequest = CreateAvailableAnswerRequest(
              questionId: q.id,
              text: availableAnswer.text,
              imageLink: null,
            );
            final res = await AvailableAnswerRepository().createAnswer(
              createAnswerRequest,
            );
            res.match(
              (e) => errors++,
              (a) {},
            );
          }
          if (errors == 0) {
            emit(
              CreateQuestionSendSuccess(
                question: Question.empty(),
                response: q,
              ),
            );
          } else {
            emit(CreateQuestionError(message: errors.toString()));
          }
        },
      );
    } else {
      emit(CreateQuestionError(message: 'Что-то пошло не так'));
    }
  }
}
