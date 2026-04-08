import 'package:json_annotation/json_annotation.dart';
import 'package:statistika_mobile/core/model/file/file.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  UserInfo({
    required this.id,
    required this.userId,
    required this.isMan,
    required this.name,
    required this.birthday,
    required this.photoId,
    required this.photo,
  });

  final String id;
  final String userId;
  final String? name;
  final bool? isMan;
  final DateTime? birthday;
  final String? photoId;
  final File? photo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
