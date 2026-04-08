// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableAnswer _$AvailableAnswerFromJson(Map<String, dynamic> json) =>
    AvailableAnswer(
      id: json['id'] as String,
      text: json['text'] as String?,
      imageLink: json['imageLink'] as String?,
      questionId: json['questionId'] as String,
    );

Map<String, dynamic> _$AvailableAnswerToJson(AvailableAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'imageLink': instance.imageLink,
      'questionId': instance.questionId,
    };
