import 'package:json_annotation/json_annotation.dart';

part 'update_admin_group.g.dart';

@JsonSerializable()
class UpdateAdminGroup {
  UpdateAdminGroup({
    required this.surveyId,
    required this.userId,
    required this.roleId,
  });

  final String surveyId;

  final String userId;

  final String roleId;

  factory UpdateAdminGroup.fromJson(Map<String, dynamic> json) =>
      _$UpdateAdminGroupFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAdminGroupToJson(this);
}
