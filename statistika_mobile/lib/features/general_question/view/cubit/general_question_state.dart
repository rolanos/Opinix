part of 'general_question_cubit.dart';

@immutable
sealed class GeneralQuestionState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GeneralQuestionEmpty extends GeneralQuestionState {}

final class GeneralQuestionLoading extends GeneralQuestionState {}

final class GeneralQuestionInitial extends GeneralQuestionState {
  GeneralQuestionInitial({required this.question});

  final Question? question;

  @override
  List<Object?> get props => [question];
}

final class GeneralQuestionError extends GeneralQuestionInitial {
  GeneralQuestionError({
    required this.message,
    super.question,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}

final class GeneralQuestionInitialAnswerLoading extends GeneralQuestionInitial {
  GeneralQuestionInitialAnswerLoading({
    required super.question,
  });
}

final class GeneralQuestionInitialShowAnalitic extends GeneralQuestionInitial {
  GeneralQuestionInitialShowAnalitic({
    required super.question,
    required this.analitic,
  });

  final AnaliticComplexResult analitic;
}
