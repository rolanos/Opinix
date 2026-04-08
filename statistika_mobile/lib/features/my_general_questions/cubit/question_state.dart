part of 'question_cubit.dart';

@immutable
sealed class QuestionState {}

final class QuestionEmpty extends QuestionState {}

final class QuestionLoading extends QuestionState {}

final class QuestionError extends QuestionState {
  final String message;

  QuestionError({
    required this.message,
  });
}

final class QuestionInitialLoaded extends QuestionState {
  final Question question;

  QuestionInitialLoaded({
    required this.question,
  });
}

final class QuestionInitial extends QuestionInitialLoaded {
  final AnaliticComplexResult? analitical;

  QuestionInitial({
    required super.question,
    this.analitical,
  });
}
