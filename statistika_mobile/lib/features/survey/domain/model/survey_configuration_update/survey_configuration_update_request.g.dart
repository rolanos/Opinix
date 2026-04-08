// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_configuration_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyConfigurationUpdateRequest _$SurveyConfigurationUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    SurveyConfigurationUpdateRequest(
      id: json['id'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isAnonymous: json['isAnonymous'] as bool,
    );

Map<String, dynamic> _$SurveyConfigurationUpdateRequestToJson(
        SurveyConfigurationUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isAnonymous': instance.isAnonymous,
    };
