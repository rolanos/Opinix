part of 'form_analitic_cubit.dart';

@immutable
sealed class FormAnaliticState {}

final class FormAnaliticEmpty extends FormAnaliticState {}

final class FormAnaliticLoading extends FormAnaliticState {}

final class FormAnaliticError extends FormAnaliticState {
  FormAnaliticError({required this.message});

  final String message;
}

final class FormAnaliticInitial extends FormAnaliticState {
  FormAnaliticInitial({
    required this.formId,
    required this.questions,
    required this.analitics,
  });
  final String formId;
  final List<Question> questions;
  final List<AnaliticComplexResult> analitics;

  AnaliticComplexResult? getAnaliticResult(String questionId) {
    final result = analitics.where(
      (elem) => elem.questionId == questionId,
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
