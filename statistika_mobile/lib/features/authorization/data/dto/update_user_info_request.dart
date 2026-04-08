import 'package:json_annotation/json_annotation.dart';

part 'update_user_info_request.g.dart';

@JsonSerializable()
class UpdateUserInfoRequest {
  UpdateUserInfoRequest({
    required this.id,
    required this.name,
    required this.isMan,
    required this.birthday,
  });

  final String id;
  final String? name;
  final bool? isMan;
  final DateTime? birthday;

  factory UpdateUserInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserInfoRequestToJson(this);
}
