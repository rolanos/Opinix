// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyConfiguration _$SurveyConfigurationFromJson(Map<String, dynamic> json) =>
    SurveyConfiguration(
      id: json['id'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isAnonymous: json['isAnonymous'] as bool,
      surveyId: json['surveyId'] as String,
    );

Map<String, dynamic> _$SurveyConfigurationToJson(
        SurveyConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isAnonymous': instance.isAnonymous,
      'surveyId': instance.surveyId,
    };
