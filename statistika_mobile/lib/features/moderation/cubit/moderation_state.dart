part of 'moderation_cubit.dart';

@immutable
sealed class ModerationState {}

final class ModerationEmpty extends ModerationState {}

final class ModerationLoading extends ModerationState {}

final class ModerationSendSuccessLoading extends ModerationLoading {}

final class ModerationError extends ModerationState {
  final String message;

  ModerationError({
    required this.message,
  });
}

final class ModerationInitial extends ModerationState {
  final Question question;

  ModerationInitial({
    required this.question,
  });
}
