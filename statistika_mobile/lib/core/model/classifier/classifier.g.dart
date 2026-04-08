// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Classifier _$ClassifierFromJson(Map<String, dynamic> json) => Classifier(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
    );

Map<String, dynamic> _$ClassifierToJson(Classifier instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentId': instance.parentId,
    };
