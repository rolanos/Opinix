// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'available_answer.g.dart';

@JsonSerializable()
class AvailableAnswer extends Equatable {
  const AvailableAnswer({
    required this.id,
    required this.text,
    required this.imageLink,
    required this.questionId,
  });

  final String id;
  final String? text;
  final String? imageLink;
  final String questionId;

  factory AvailableAnswer.fromJson(Map<String, dynamic> json) =>
      _$AvailableAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableAnswerToJson(this);

  factory AvailableAnswer.empty() => const AvailableAnswer(
        id: '',
        text: null,
        imageLink: null,
        questionId: '',
      );

  @override
  List<Object?> get props => [
        id,
        text,
        imageLink,
        questionId,
      ];

  AvailableAnswer copyWith({
    String? id,
    String? text,
    String? imageLink,
    String? questionId,
  }) {
    return AvailableAnswer(
      id: id ?? this.id,
      text: text ?? this.text,
      imageLink: imageLink ?? this.imageLink,
      questionId: questionId ?? this.questionId,
    );
  }
}
