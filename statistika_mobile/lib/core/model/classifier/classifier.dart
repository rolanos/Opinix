import 'package:json_annotation/json_annotation.dart';
import 'package:statistika_mobile/core/model/named_type.dart';

part 'classifier.g.dart';

@JsonSerializable()
class Classifier implements NamedType {
  Classifier({
    required this.id,
    required this.name,
    required this.parentId,
  });

  final String id;
  @override
  final String name;
  final String? parentId;

  factory Classifier.fromJson(Map<String, dynamic> json) =>
      _$ClassifierFromJson(json);

  Map<String, dynamic> toJson() => _$ClassifierToJson(this);
}
