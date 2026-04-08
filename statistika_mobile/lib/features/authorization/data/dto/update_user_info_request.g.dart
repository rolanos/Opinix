// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserInfoRequest _$UpdateUserInfoRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserInfoRequest(
      id: json['id'] as String,
      name: json['name'] as String?,
      isMan: json['isMan'] as bool?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
    );

Map<String, dynamic> _$UpdateUserInfoRequestToJson(
        UpdateUserInfoRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isMan': instance.isMan,
      'birthday': instance.birthday?.toIso8601String(),
    };
