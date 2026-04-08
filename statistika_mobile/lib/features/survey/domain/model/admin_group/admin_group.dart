import 'package:json_annotation/json_annotation.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user.dart';

import '../../../../../core/model/classifier/classifier.dart';

part 'admin_group.g.dart';

@JsonSerializable()
class AdminGroup {
  AdminGroup({
    required this.surveyId,
    required this.userId,
    required this.user,
    required this.roleId,
    required this.role,
  });

  final String surveyId;
  final String? userId;
  final User? user;
  final String? roleId;
  final Classifier? role;

  factory AdminGroup.fromJson(Map<String, dynamic> json) =>
      _$AdminGroupFromJson(json);

  Map<String, dynamic> toJson() => _$AdminGroupToJson(this);
}
