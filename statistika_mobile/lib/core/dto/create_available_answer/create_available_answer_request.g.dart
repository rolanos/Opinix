// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_available_answer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAvailableAnswerRequest _$CreateAvailableAnswerRequestFromJson(
        Map<String, dynamic> json) =>
    CreateAvailableAnswerRequest(
      questionId: json['questionId'] as String,
      text: json['text'] as String?,
      imageLink: json['imageLink'] as String?,
    );

Map<String, dynamic> _$CreateAvailableAnswerRequestToJson(
        CreateAvailableAnswerRequest instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'text': instance.text,
      'imageLink': instance.imageLink,
    };
