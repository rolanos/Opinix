part of 'survey_configuration_cubit.dart';

@immutable
sealed class SurveyConfigurationState {}

final class SurveyConfigurationEmpty extends SurveyConfigurationState {}

final class SurveyConfigurationLoading extends SurveyConfigurationState {}

final class SurveyConfigurationError extends SurveyConfigurationState {
  SurveyConfigurationError({
    required this.message,
    this.surveyId,
  });

  final String? surveyId;

  final String message;
}

final class SurveyConfigurationInitial extends SurveyConfigurationState {
  SurveyConfigurationInitial({required this.surveyConfiguration});

  final SurveyConfiguration surveyConfiguration;
}

final class SurveyConfigurationUpdateLoading
    extends SurveyConfigurationInitial {
  SurveyConfigurationUpdateLoading({
    required super.surveyConfiguration,
  });
}
