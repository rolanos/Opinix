// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_available_answer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAvailableAnswerRequest _$UpdateAvailableAnswerRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateAvailableAnswerRequest(
      id: json['id'] as String,
      text: json['text'] as String?,
      imageLink: json['imageLink'] as String?,
    );

Map<String, dynamic> _$UpdateAvailableAnswerRequestToJson(
        UpdateAvailableAnswerRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'imageLink': instance.imageLink,
    };
