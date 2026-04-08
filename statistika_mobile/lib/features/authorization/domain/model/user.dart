// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user_info.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.userInfo,
    required this.createdDate,
    required this.updatedDate,
  });

  final String id;
  final String? name;
  final String? surname;
  final String? username;
  final String email;
  final UserInfo? userInfo;
  final DateTime createdDate;
  final DateTime updatedDate;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? username,
    String? email,
    UserInfo? userInfo,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      username: username ?? this.username,
      email: email ?? this.email,
      userInfo: userInfo ?? this.userInfo,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }
}
