import 'package:json_annotation/json_annotation.dart';

part 'survey.g.dart';

@JsonSerializable()
class Survey {
  Survey({
    required this.id,
    required this.createdById,
    required this.createdByName,
  });

  final String id;
  final String? createdById;
  final String? createdByName;

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyToJson(this);
}
