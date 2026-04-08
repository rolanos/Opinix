import 'package:json_annotation/json_annotation.dart';
import 'package:statistika_mobile/core/dto/create_answer/create_answer_request.dart';

part 'create_answers_to_form_request.g.dart';

@JsonSerializable()
class CreateAnswersToFormRequest {
  CreateAnswersToFormRequest({
    required this.formId,
    required this.answers,
  });

  final String formId;
  final List<CreateAnswerRequest> answers;

  factory CreateAnswersToFormRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAnswersToFormRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAnswersToFormRequestToJson(this);
}
