import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable()
class File {
  File({
    required this.id,
    required this.fullName,
    required this.size,
    required this.elementId,
    required this.createdDate,
  });

  final String id;
  final String fullName;
  final int size;
  final String elementId;
  final DateTime createdDate;

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  Map<String, dynamic> toJson() => _$FileToJson(this);
}
