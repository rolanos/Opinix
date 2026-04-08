// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminGroup _$AdminGroupFromJson(Map<String, dynamic> json) => AdminGroup(
      surveyId: json['surveyId'] as String,
      userId: json['userId'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      roleId: json['roleId'] as String?,
      role: json['role'] == null
          ? null
          : Classifier.fromJson(json['role'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdminGroupToJson(AdminGroup instance) =>
    <String, dynamic>{
      'surveyId': instance.surveyId,
      'userId': instance.userId,
      'user': instance.user,
      'roleId': instance.roleId,
      'role': instance.role,
    };
