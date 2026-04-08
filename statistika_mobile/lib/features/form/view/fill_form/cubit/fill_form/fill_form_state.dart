part of 'fill_form_cubit.dart';

@immutable
sealed class FillFormState {}

final class FillFormEmpty extends FillFormState {}

final class FillFormLoading extends FillFormState {}

final class FillFormSended extends FillFormState {}

final class FillFormError extends FillFormState {
  FillFormError({required this.message});

  final String message;
}

final class FillFormInitial extends FillFormState {
  FillFormInitial({
    required this.formId,
    required this.sections,
    required this.currentSection,
    required this.currentQuestion,
    required this.countQuestions,
    required this.currentQuestionIndex,
    this.answers = const [],
  });

  final String formId;

  final List<Section> sections;

  final Section currentSection;
  final Question currentQuestion;

  final List<CreateAnswerRequest> answers;

  final int countQuestions;
  final int currentQuestionIndex;

  bool get isFirstQuestion => currentQuestionIndex == 0;

  bool get isLastQuestion => currentQuestionIndex == (countQuestions - 1);

  FillFormInitial copyWith({
    String? formId,
    List<Section>? sections,
    Section? currentSection,
    Question? currentQuestion,
    List<CreateAnswerRequest>? answers,
    int? countQuestions,
    int? currentQuestionIndex,
  }) {
    return FillFormInitial(
      formId: formId ?? this.formId,
      sections: sections ?? this.sections,
      currentSection: currentSection ?? this.currentSection,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      answers: answers ?? this.answers,
      countQuestions: countQuestions ?? this.countQuestions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }
}
