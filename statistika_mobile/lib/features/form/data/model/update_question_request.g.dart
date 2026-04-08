// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_question_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateQuestionRequest _$UpdateQuestionRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateQuestionRequest(
      id: json['id'] as String,
      title: json['title'] as String?,
      pastQuestion: json['pastQuestion'] as String?,
      nextQuestion: json['nextQuestion'] as String?,
    );

Map<String, dynamic> _$UpdateQuestionRequestToJson(
        UpdateQuestionRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'pastQuestion': instance.pastQuestion,
      'nextQuestion': instance.nextQuestion,
    };
