// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_form_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateFormRequest _$CreateFormRequestFromJson(Map<String, dynamic> json) =>
    CreateFormRequest(
      name: json['name'] as String,
      description: json['description'] as String,
      typeId: json['typeId'] as String?,
      createdById: json['createdById'] as String,
    );

Map<String, dynamic> _$CreateFormRequestToJson(CreateFormRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'typeId': instance.typeId,
      'createdById': instance.createdById,
    };
