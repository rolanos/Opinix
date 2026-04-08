// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_answers_to_form_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAnswersToFormRequest _$CreateAnswersToFormRequestFromJson(
        Map<String, dynamic> json) =>
    CreateAnswersToFormRequest(
      formId: json['formId'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => CreateAnswerRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateAnswersToFormRequestToJson(
        CreateAnswersToFormRequest instance) =>
    <String, dynamic>{
      'formId': instance.formId,
      'answers': instance.answers,
    };
