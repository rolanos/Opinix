// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analitical_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnaliticalResult _$AnaliticalResultFromJson(Map<String, dynamic> json) =>
    AnaliticalResult(
      answerId: json['answerId'] as String?,
      answerValue: json['answerValue'] as String?,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$AnaliticalResultToJson(AnaliticalResult instance) =>
    <String, dynamic>{
      'answerId': instance.answerId,
      'answerValue': instance.answerValue,
      'count': instance.count,
    };
