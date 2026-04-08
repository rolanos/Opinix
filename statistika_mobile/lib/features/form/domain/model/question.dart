// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  const Question({
    required this.id,
    required this.title,
    required this.typeId,
    required this.formId,
    required this.sectionId,
    required this.createdDate,
    required this.isModerated,
    required this.availableAnswers,
  });

  final String id;
  final String title;
  final String? typeId;
  final String formId;
  final String? sectionId;
  final DateTime createdDate;
  final bool isModerated;
  final List<AvailableAnswer> availableAnswers;

  factory Question.empty() => Question(
        id: '',
        title: '',
        typeId: '',
        formId: '',
        sectionId: '',
        createdDate: DateTime.now(),
        isModerated: false,
        availableAnswers: const [],
      );

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        typeId,
        formId,
        sectionId,
        createdDate,
        availableAnswers,
      ];

  Question copyWith({
    String? id,
    String? title,
    String? typeId,
    String? formId,
    String? sectionId,
    DateTime? createdDate,
    bool? isModerated,
    List<AvailableAnswer>? availableAnswers,
  }) {
    return Question(
      id: id ?? this.id,
      title: title ?? this.title,
      typeId: typeId ?? this.typeId,
      formId: formId ?? this.formId,
      sectionId: sectionId ?? this.sectionId,
      createdDate: createdDate ?? this.createdDate,
      isModerated: isModerated ?? this.isModerated,
      availableAnswers: availableAnswers ?? this.availableAnswers,
    );
  }
}
