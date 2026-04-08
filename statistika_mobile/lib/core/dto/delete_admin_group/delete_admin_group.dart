import 'package:json_annotation/json_annotation.dart';

part 'delete_admin_group.g.dart';

@JsonSerializable()
class DeleteAdminGroup {
  DeleteAdminGroup({
    required this.surveyId,
    required this.userId,
  });

  final String surveyId;

  final String userId;

  factory DeleteAdminGroup.fromJson(Map<String, dynamic> json) =>
      _$DeleteAdminGroupFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAdminGroupToJson(this);
}
