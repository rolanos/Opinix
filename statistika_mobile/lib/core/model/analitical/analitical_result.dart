import 'package:json_annotation/json_annotation.dart';

part 'analitical_result.g.dart';

@JsonSerializable()
class AnaliticalResult {
  AnaliticalResult({
    required this.answerId,
    required this.answerValue,
    required this.count,
  });

  final String? answerId;
  final String? answerValue;
  final int count;

  factory AnaliticalResult.fromJson(Map<String, dynamic> json) =>
      _$AnaliticalResultFromJson(json);

  Map<String, dynamic> toJson() => _$AnaliticalResultToJson(this);
}
