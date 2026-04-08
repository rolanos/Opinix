// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Form _$FormFromJson(Map<String, dynamic> json) => Form(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      surveyId: json['surveyId'] as String,
      createdById: json['createdById'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$FormToJson(Form instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'surveyId': instance.surveyId,
      'createdById': instance.createdById,
      'createdDate': instance.createdDate.toIso8601String(),
    };
