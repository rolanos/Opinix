import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/dto/create_question/create_question_request.dart';
import 'package:statistika_mobile/core/dto/update_available_answer/update_available_answer_request.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/form/data/model/update_question_request.dart';
import 'package:statistika_mobile/core/repository/available_answer_repository.dart';
import 'package:statistika_mobile/features/form/data/repository/form_repository.dart';
import 'package:statistika_mobile/core/repository/question_repository.dart';
import 'package:statistika_mobile/features/form/data/repository/section_repository.dart';
import 'package:statistika_mobile/features/form/domain/enum/question_types.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';
import 'package:statistika_mobile/features/form/domain/model/form.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';
import 'package:statistika_mobile/features/form/domain/model/section.dart';

import '../../../../../core/dto/create_available_answer/create_available_answer_request.dart';

part 'form_editer_state.dart';

class FormEditerCubit extends Cubit<FormEditerState> {
  FormEditerCubit() : super(FormEditerLoading());

  ///обновляем модель Form
  Future<void> update({String? formId}) async {
    if (formId == null || formId.isEmpty) {
      if (state.form?.id != null) {
        formId = state.form?.id;
      }
      if (formId == null) {
        emit(FormEditerError(message: 'Ошибка'));
        return;
      }
    }

    final stateSnap = state;
    if (stateSnap is FormEditerInitial) {
      emit(
        FormEditerInitialLoading(
          form: stateSnap.form,
          sections: stateSnap.sections,
        ),
      );
    }

    final form = await FormRepository().getFormById(formId);

    form.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) async {
        final sectionsResult = await SectionRepository().getSections(f.id);
        sectionsResult.match(
          (e) => emit(FormEditerError(message: e.toString())),
          (s) => emit(FormEditerInitial(form: f, sections: s)),
        );
      },
    );
  }

  //Добавляем новый вопрос в список вопросов
  Future<void> addNewQuestion(Section section, String title, QuestionTypes type) async {
    final createRequest = CreateQuestionRequest(
      title: title,
      pastQuestion: null,
      nextQuestion: null,
      typeId: type.id,
      sectionId: section.id,
      isGeneral: false,
      userId: await SharedPreferencesManager.getUserId(),
    );
    final result = await QuestionRepository().createQuestion(createRequest);

    result.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) async => update(),
    );
  }

  //Добавляем новый вопрос в список вопросов
  Future<void> deleteQuestion(Question question) async {
    final result = await QuestionRepository().deleteQuestion(question.id);

    result.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) async => update(),
    );
  }

  //Обновляем вопрос
  Future<void> updateQuestion(
    Question question, {
    String? title,
    String? nextQuestion,
    String? pastQuestion,
  }) async {
    final request = UpdateQuestionRequest(
      id: question.id,
      title: title,
      nextQuestion: nextQuestion,
      pastQuestion: pastQuestion,
    );

    final result = await QuestionRepository().updateQuestion(request);

    result.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) async => update(),
    );
  }

  //Добавление варианта вопроса
  Future<void> addAvailableAnswer(Question question) async {
    final createRequest = CreateAvailableAnswerRequest(
      questionId: question.id,
      text: '',
      imageLink: null,
    );

    final result =
        await AvailableAnswerRepository().createAnswer(createRequest);

    result.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) async => update(),
    );
  }

  //Обновление варианта ответа
  Future<void> updateAvailableAnswer(
    AvailableAnswer availableAnswer, {
    String? text,
    String? imageUrl,
  }) async {
    final createRequest = UpdateAvailableAnswerRequest(
      id: availableAnswer.id,
      text: text,
      imageLink: imageUrl,
    );

    final result =
        await AvailableAnswerRepository().updateAnswer(createRequest);

    result.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) async => update(),
    );
  }

  //Удаление варианта вопроса
  Future<void> deleteAvailableAnswer(AvailableAnswer availableAnswer) async {
    final result = await AvailableAnswerRepository().deleteAnswer(
      availableAnswer.id,
    );

    result.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) async => update(),
    );
  }
}
