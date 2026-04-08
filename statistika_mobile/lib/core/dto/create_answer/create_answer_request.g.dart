// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_answer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAnswerRequest _$CreateAnswerRequestFromJson(Map<String, dynamic> json) =>
    CreateAnswerRequest(
      questionId: json['questionId'] as String,
      answerValueIds: (json['answerValueIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$CreateAnswerRequestToJson(
        CreateAnswerRequest instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'answerValueIds': instance.answerValueIds,
      'userId': instance.userId,
    };
