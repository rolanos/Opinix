import 'package:json_annotation/json_annotation.dart';

part 'create_admin_group.g.dart';

@JsonSerializable()
class CreateAdminGroup {
  CreateAdminGroup({
    required this.userEmail,
    required this.surveyId,
  });

  final String userEmail;

  final String surveyId;

  factory CreateAdminGroup.fromJson(Map<String, dynamic> json) =>
      _$CreateAdminGroupFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAdminGroupToJson(this);
}
