import 'package:json_annotation/json_annotation.dart';

part 'create_question_request.g.dart';

@JsonSerializable()
class CreateQuestionRequest {
  CreateQuestionRequest({
    required this.title,
    required this.pastQuestion,
    required this.nextQuestion,
    required this.typeId,
    required this.sectionId,
    required this.userId,
    required this.isGeneral,
  });

  final String title;
  final String? pastQuestion;
  final String? nextQuestion;
  final String typeId;
  final String? sectionId;
  final String? userId;
  final bool? isGeneral;

  factory CreateQuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateQuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQuestionRequestToJson(this);
}
