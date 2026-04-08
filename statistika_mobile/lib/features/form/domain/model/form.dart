import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form.g.dart';

@JsonSerializable()
class Form extends Equatable {
  Form({
    required this.id,
    required this.name,
    required this.description,
    required this.surveyId,
    required this.createdById,
    required this.createdDate,
  });

  final String id;
  final String name;
  final String description;
  final String surveyId;
  final String createdById;
  final DateTime createdDate;

  factory Form.fromJson(Map<String, dynamic> json) => _$FormFromJson(json);

  Map<String, dynamic> toJson() => _$FormToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        surveyId,
        createdById,
        createdDate,
      ];
}
