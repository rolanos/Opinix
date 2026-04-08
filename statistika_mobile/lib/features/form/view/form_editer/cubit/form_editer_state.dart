part of 'form_editer_cubit.dart';

@immutable
sealed class FormEditerState extends Equatable {
  abstract final Form? form;
  abstract final List<Section>? sections;
}

final class FormEditerLoading extends FormEditerState {
  @override
  Form? get form => null;

  @override
  List<Section>? get sections => null;

  @override
  List<Object?> get props => [form, sections];
}

final class FormEditerError extends FormEditerState {
  FormEditerError({required this.message});

  final String message;

  @override
  Form? get form => null;

  @override
  List<Section>? get sections => null;

  @override
  List<Object?> get props => [message];
}

final class FormEditerInitial extends FormEditerState {
  FormEditerInitial({
    required this.form,
    this.sections = const [],
  });

  @override
  final Form form;

  @override
  final List<Section> sections;

  @override
  List<Object?> get props => [form, sections];
}

final class FormEditerInitialLoading extends FormEditerInitial {
  FormEditerInitialLoading({required super.form, super.sections});
}
