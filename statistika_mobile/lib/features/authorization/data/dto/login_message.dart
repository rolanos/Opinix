import 'package:json_annotation/json_annotation.dart';

part 'login_message.g.dart';

@JsonSerializable()
class LoginMessage {
  LoginMessage({
    required this.message,
    required this.email,
  });

  final String message;
  final String? email;

  factory LoginMessage.fromJson(Map<String, dynamic> json) =>
      _$LoginMessageFromJson(json);

  Map<String, dynamic> toJson() => _$LoginMessageToJson(this);
}
