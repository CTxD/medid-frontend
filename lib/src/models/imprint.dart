import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'imprint.g.dart';

@JsonSerializable()
class Imprint {
  final String path;
  final String imgasbytes;

  Imprint({this.path, this.imgasbytes});

  factory Imprint.fromJson(Map<String, dynamic> json) =>
      _$ImprintFromJson(json);
  Map<String, dynamic> toJson() => _$ImprintToJson(this);
}