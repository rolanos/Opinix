import 'package:json_annotation/json_annotation.dart';

part 'create_form_request.g.dart';

@JsonSerializable()
class CreateFormRequest {
  CreateFormRequest({
    required this.name,
    required this.description,
    required this.typeId,
    required this.createdById,
  });

  final String name;
  final String description;
  final String? typeId;
  final String createdById;

  factory CreateFormRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateFormRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateFormRequestToJson(this);
}
