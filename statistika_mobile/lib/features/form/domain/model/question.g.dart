// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as String,
      title: json['title'] as String,
      typeId: json['typeId'] as String?,
      formId: json['formId'] as String,
      sectionId: json['sectionId'] as String?,
      createdDate: DateTime.parse(json['createdDate'] as String),
      isModerated: json['isModerated'] as bool,
      availableAnswers: (json['availableAnswers'] as List<dynamic>)
          .map((e) => AvailableAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'typeId': instance.typeId,
      'formId': instance.formId,
      'sectionId': instance.sectionId,
      'createdDate': instance.createdDate.toIso8601String(),
      'isModerated': instance.isModerated,
      'availableAnswers': instance.availableAnswers,
    };
