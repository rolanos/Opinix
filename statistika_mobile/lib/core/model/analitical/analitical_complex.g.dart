// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analitical_complex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnaliticComplexResult _$AnaliticComplexResultFromJson(
        Map<String, dynamic> json) =>
    AnaliticComplexResult(
      totalCount: (json['totalCount'] as num).toInt(),
      questionId: json['questionId'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => AnaliticalResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnaliticComplexResultToJson(
        AnaliticComplexResult instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'questionId': instance.questionId,
      'data': instance.data,
    };
