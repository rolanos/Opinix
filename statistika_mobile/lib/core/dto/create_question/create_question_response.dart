import 'package:json_annotation/json_annotation.dart';

part 'create_question_response.g.dart';

@JsonSerializable()
class CreateQuestionResponse {
  CreateQuestionResponse({
    required this.message,
    required this.id,
  });

  final String message;
  final String id;

  factory CreateQuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateQuestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQuestionResponseToJson(this);
}
