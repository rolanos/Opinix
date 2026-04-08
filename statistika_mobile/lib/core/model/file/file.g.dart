// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) => File(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      size: (json['size'] as num).toInt(),
      elementId: json['elementId'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'size': instance.size,
      'elementId': instance.elementId,
      'createdDate': instance.createdDate.toIso8601String(),
    };
