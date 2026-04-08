import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

part 'section.g.dart';

@JsonSerializable()
class Section extends Equatable {
  const Section({
    required this.id,
    required this.title,
    required this.formId,
    required this.order,
    required this.questions,
  });

  final String id;
  final String? title;
  final String formId;
  final int? order;
  final List<Question> questions;

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        formId,
        order,
        questions,
      ];
}
