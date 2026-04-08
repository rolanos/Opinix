import 'package:json_annotation/json_annotation.dart';

part 'update_question_request.g.dart';

@JsonSerializable()
class UpdateQuestionRequest {
  UpdateQuestionRequest({
    required this.id,
    this.title,
    this.pastQuestion,
    this.nextQuestion,
  });

  final String id;
  final String? title;
  final String? pastQuestion;
  final String? nextQuestion;

  factory UpdateQuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateQuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateQuestionRequestToJson(this);
}
