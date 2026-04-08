part of 'authorization_cubit.dart';

@immutable
sealed class AuthorizationState {}

final class AuthorizationEmpty extends AuthorizationState {}

final class AuthorizationLoading extends AuthorizationState {}

final class AuthorizationAcceptEmail extends AuthorizationState {
  AuthorizationAcceptEmail({
    required this.message,
  });

  final LoginMessage message;
}

final class AuthorizationAcceptRedirect extends AuthorizationAcceptEmail {
  AuthorizationAcceptRedirect({
    required super.message,
  });
}

final class AuthorizationAcceptLoading extends AuthorizationAcceptEmail {
  AuthorizationAcceptLoading({
    required super.message,
  });
}

final class AuthorizationAcceptError extends AuthorizationAcceptEmail {
  AuthorizationAcceptError({
    required super.message,
    required this.errorMessage,
  });

  final String errorMessage;
}

final class AuthorizationInited extends AuthorizationState {
  final User user;

  AuthorizationInited({
    required this.user,
  });
}

final class AuthorizationError extends AuthorizationState {
  final String message;

  AuthorizationError({
    required this.message,
  });
}

final class AuthorizationMessage extends AuthorizationState {
  final String message;

  AuthorizationMessage({
    required this.message,
  });
}
