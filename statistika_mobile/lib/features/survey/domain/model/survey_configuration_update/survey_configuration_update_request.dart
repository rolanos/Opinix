import 'package:json_annotation/json_annotation.dart';

part 'survey_configuration_update_request.g.dart';

@JsonSerializable()
class SurveyConfigurationUpdateRequest {
  SurveyConfigurationUpdateRequest({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.isAnonymous,
  });

  final String id;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isAnonymous;

  factory SurveyConfigurationUpdateRequest.fromJson(
          Map<String, dynamic> json) =>
      _$SurveyConfigurationUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SurveyConfigurationUpdateRequestToJson(this);
}
