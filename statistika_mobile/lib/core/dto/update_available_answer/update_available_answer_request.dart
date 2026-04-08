import 'package:json_annotation/json_annotation.dart';

part 'update_available_answer_request.g.dart';

@JsonSerializable()
class UpdateAvailableAnswerRequest {
  UpdateAvailableAnswerRequest({
    required this.id,
    this.text,
    this.imageLink,
  });

  final String id;
  final String? text;
  final String? imageLink;

  factory UpdateAvailableAnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAvailableAnswerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAvailableAnswerRequestToJson(this);
}
