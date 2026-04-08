part of 'my_general_questions_cubit.dart';

@immutable
sealed class MyGeneralQuestionsState {}

final class MyGeneralQuestionsEmpty extends MyGeneralQuestionsState {}

final class MyGeneralQuestionsError extends MyGeneralQuestionsState {
  final String message;

  MyGeneralQuestionsError({required this.message});
}

final class MyGeneralQuestionsLoading extends MyGeneralQuestionsState {}

final class MyGeneralQuestionsInitial extends MyGeneralQuestionsState {
  final List<Question> questions;

  MyGeneralQuestionsInitial({
    required this.questions,
  });
}
