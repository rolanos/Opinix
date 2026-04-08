import 'package:json_annotation/json_annotation.dart';

part 'analitic_request.g.dart';

@JsonSerializable()
class AnaliticRequest {
  AnaliticRequest({
    this.gender,
    this.ageFrom,
    this.ageTo,
  });

  final bool? gender;

  final int? ageFrom;

  final int? ageTo;

  factory AnaliticRequest.fromJson(Map<String, dynamic> json) =>
      _$AnaliticRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AnaliticRequestToJson(this);
}
