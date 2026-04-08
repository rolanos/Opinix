// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_question_cubit.dart';

@immutable
sealed class CreateQuestionState {}

final class CreateQuestionEmpty extends CreateQuestionState {}

final class CreateQuestionError extends CreateQuestionState {
  CreateQuestionError({
    required this.message,
  });

  final String message;
}

final class CreateQuestionInitial extends CreateQuestionState {
  CreateQuestionInitial({
    required this.question,
  });

  final Question question;

  CreateQuestionInitial copyWith({
    Question? question,
  }) {
    return CreateQuestionInitial(
      question: question ?? this.question,
    );
  }
}

final class CreateQuestionSendLoading extends CreateQuestionInitial {
  CreateQuestionSendLoading({required super.question});
}

final class CreateQuestionSendSuccess extends CreateQuestionInitial {
  CreateQuestionSendSuccess({
    required super.question,
    required this.response,
  });

  final CreateQuestionResponse response;
}
