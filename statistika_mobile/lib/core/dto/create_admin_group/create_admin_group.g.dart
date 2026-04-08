// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_admin_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAdminGroup _$CreateAdminGroupFromJson(Map<String, dynamic> json) =>
    CreateAdminGroup(
      userEmail: json['userEmail'] as String,
      surveyId: json['surveyId'] as String,
    );

Map<String, dynamic> _$CreateAdminGroupToJson(CreateAdminGroup instance) =>
    <String, dynamic>{
      'userEmail': instance.userEmail,
      'surveyId': instance.surveyId,
    };
