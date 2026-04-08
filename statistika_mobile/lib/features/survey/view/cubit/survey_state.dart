part of 'survey_cubit.dart';

@immutable
sealed class SurveyState {}

final class SurveyLoading extends SurveyState {}

final class SurveyError extends SurveyState {
  final String message;

  SurveyError({required this.message});
}

final class SurveyInitial extends SurveyState {
  final List<Survey> surveys;

  SurveyInitial({
    required this.surveys,
  });
}
