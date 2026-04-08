// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_admin_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAdminGroup _$UpdateAdminGroupFromJson(Map<String, dynamic> json) =>
    UpdateAdminGroup(
      surveyId: json['surveyId'] as String,
      userId: json['userId'] as String,
      roleId: json['roleId'] as String,
    );

Map<String, dynamic> _$UpdateAdminGroupToJson(UpdateAdminGroup instance) =>
    <String, dynamic>{
      'surveyId': instance.surveyId,
      'userId': instance.userId,
      'roleId': instance.roleId,
    };
