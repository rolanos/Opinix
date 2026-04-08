// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: json['id'] as String,
      userId: json['userId'] as String,
      isMan: json['isMan'] as bool?,
      name: json['name'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      photoId: json['photoId'] as String?,
      photo: json['photo'] == null
          ? null
          : File.fromJson(json['photo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'isMan': instance.isMan,
      'birthday': instance.birthday?.toIso8601String(),
      'photoId': instance.photoId,
      'photo': instance.photo,
    };
