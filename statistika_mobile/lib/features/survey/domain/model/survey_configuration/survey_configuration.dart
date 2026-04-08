import 'package:json_annotation/json_annotation.dart';

part 'survey_configuration.g.dart';

@JsonSerializable()
class SurveyConfiguration {
  SurveyConfiguration({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.isAnonymous,
    required this.surveyId,
  });

  final String id;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isAnonymous;
  final String surveyId;

  factory SurveyConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SurveyConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyConfigurationToJson(this);
}
