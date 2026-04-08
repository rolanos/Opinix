// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_question_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateQuestionRequest _$CreateQuestionRequestFromJson(
        Map<String, dynamic> json) =>
    CreateQuestionRequest(
      title: json['title'] as String,
      pastQuestion: json['pastQuestion'] as String?,
      nextQuestion: json['nextQuestion'] as String?,
      typeId: json['typeId'] as String,
      sectionId: json['sectionId'] as String?,
      userId: json['userId'] as String?,
      isGeneral: json['isGeneral'] as bool?,
    );

Map<String, dynamic> _$CreateQuestionRequestToJson(
        CreateQuestionRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'pastQuestion': instance.pastQuestion,
      'nextQuestion': instance.nextQuestion,
      'typeId': instance.typeId,
      'sectionId': instance.sectionId,
      'userId': instance.userId,
      'isGeneral': instance.isGeneral,
    };
