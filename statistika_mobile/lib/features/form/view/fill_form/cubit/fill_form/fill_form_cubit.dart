import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/dto/create_answer/create_answer_request.dart';
import 'package:statistika_mobile/core/dto/create_answer/create_answers_to_form_request.dart';
import 'package:statistika_mobile/core/repository/answer_repository.dart';
import 'package:statistika_mobile/features/form/data/repository/section_repository.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';
import 'package:statistika_mobile/features/form/domain/model/section.dart';

part 'fill_form_state.dart';

class FillFormCubit extends Cubit<FillFormState> {
  FillFormCubit() : super(FillFormEmpty());

  Future<void> start(String? formId) async {
    if (formId == null || formId.isEmpty) {
      emit(FillFormError(message: 'Ошибка, попробуйте позже'));
      return;
    }
    emit(FillFormLoading());
    final sections = await SectionRepository().getSections(formId);
    sections.match(
      (e) => emit(FillFormError(message: e.toString())),
      (list) async {
        var countQuestions = 0;
        await for (var section in Stream.fromIterable(list)) {
          countQuestions += section.questions.length;
        }
        if (list.isEmpty) {
          emit(FillFormError(message: 'Ошибка, анкета пуста'));
          return;
        }
        if (list.first.questions.isNotEmpty) {
          emit(
            FillFormInitial(
              formId: formId,
              sections: list,
              currentSection: list.first,
              currentQuestion: list.first.questions.first,
              countQuestions: countQuestions,
              currentQuestionIndex: 0,
            ),
          );
        } else {
          emit(FillFormError(message: 'Ошибка, секция пуста'));
        }
      },
    );
  }

  ///Следующий вопрос
  void nextQuestion() {
    final state = this.state;
    if (state is FillFormInitial) {
      final currentIndex = state.currentSection.questions
          .indexWhere((q) => q.id == state.currentQuestion.id);
      if (currentIndex != -1 &&
          currentIndex < state.currentSection.questions.length - 1) {
        emit(
          state.copyWith(
            currentQuestion: state.currentSection.questions[currentIndex + 1],
            currentQuestionIndex: state.currentQuestionIndex + 1,
          ),
        );
      }
    }
  }

  ///Прошлый вопрос
  void pastQuestion() {
    final state = this.state;
    if (state is FillFormInitial) {
      final currentIndex = state.currentSection.questions
          .indexWhere((q) => q.id == state.currentQuestion.id);
      if (currentIndex > 0) {
        emit(
          state.copyWith(
            currentQuestion: state.currentSection.questions[currentIndex - 1],
            currentQuestionIndex: state.currentQuestionIndex - 1,
          ),
        );
      }
    }
  }

  ///Получить сделанный ответ синхронно
  AvailableAnswer? getAnswer(Question question) {
    final state = this.state;
    if (state is FillFormInitial) {
      final answersCopy = List<CreateAnswerRequest>.from(state.answers);
      for (var value in answersCopy) {
        if (question.id == value.questionId) {
          final answer = question.availableAnswers
              .where((a) => value.answerValueIds.contains(a.id))
              .toList();
          if (answer.isNotEmpty) {
            return answer.first;
          }
        }
      }
    }
    return null;
  }

  ///Обновляем если поменялся ответ
  void updateAnswer(CreateAnswerRequest answer) {
    final state = this.state;
    if (state is FillFormInitial) {
      final answersCopy = List<CreateAnswerRequest>.from(state.answers);
      for (var value in answersCopy) {
        if (answer.questionId == value.questionId) {
          answersCopy.removeWhere((a) => answer.questionId == value.questionId);
          answersCopy.add(answer);
          break;
        }
      }
      answersCopy.add(answer);
      emit(state.copyWith(answers: answersCopy));
    }
  }

  //Отправляем форму
  Future<void> sendForm() async {
    final state = this.state;
    if (state is FillFormInitial) {
      final request = CreateAnswersToFormRequest(
        formId: state.formId,
        answers: state.answers,
      );
      final result = await AnswerRepository().sendFormAnswers(request);
      result.match(
        (e) {},
        (str) => emit(
          FillFormSended(),
        ),
      );
    }
  }
}
