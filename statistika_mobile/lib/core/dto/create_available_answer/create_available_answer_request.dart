import 'package:json_annotation/json_annotation.dart';

part 'create_available_answer_request.g.dart';

@JsonSerializable()
class CreateAvailableAnswerRequest {
  CreateAvailableAnswerRequest({
    required this.questionId,
    required this.text,
    required this.imageLink,
  });

  final String questionId;
  final String? text;
  final String? imageLink;

  factory CreateAvailableAnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAvailableAnswerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAvailableAnswerRequestToJson(this);
}
