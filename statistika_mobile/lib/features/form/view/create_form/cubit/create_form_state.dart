part of 'create_form_cubit.dart';

@immutable
sealed class CreateFormState {}

final class CreateFormEmpty extends CreateFormState {}

final class CreateFormError extends CreateFormState {
  CreateFormError({required this.message});

  final String message;
}

final class CreateFormLoading extends CreateFormState {}

final class CreateFormCreated extends CreateFormState {
  CreateFormCreated({required this.form});

  final Form form;
}
