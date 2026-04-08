// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analitic_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnaliticRequest _$AnaliticRequestFromJson(Map<String, dynamic> json) =>
    AnaliticRequest(
      gender: json['gender'] as bool?,
      ageFrom: (json['ageFrom'] as num?)?.toInt(),
      ageTo: (json['ageTo'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AnaliticRequestToJson(AnaliticRequest instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'ageFrom': instance.ageFrom,
      'ageTo': instance.ageTo,
    };
