// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginMessage _$LoginMessageFromJson(Map<String, dynamic> json) => LoginMessage(
      message: json['message'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$LoginMessageToJson(LoginMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'email': instance.email,
    };
