import 'package:json_annotation/json_annotation.dart';

import 'analitical_result.dart';

part 'analitical_complex.g.dart';

@JsonSerializable()
class AnaliticComplexResult {
  AnaliticComplexResult({
    required this.totalCount,
    required this.questionId,
    required this.data,
  });

  final int totalCount;
  final String questionId;
  final List<AnaliticalResult> data;

  factory AnaliticComplexResult.fromJson(Map<String, dynamic> json) =>
      _$AnaliticComplexResultFromJson(json);

  Map<String, dynamic> toJson() => _$AnaliticComplexResultToJson(this);

  AnaliticalResult? findByAnswerIdSingle(String answerId) {
    final result = data.where((elem) => elem.answerId == answerId);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
