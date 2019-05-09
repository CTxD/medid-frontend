import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'imprint.g.dart';

@JsonSerializable()
class Imprint {
  final int id;
  final String imgasbytes;

  Imprint({this.id, this.imgasbytes});

  factory Imprint.fromJson(Map<String, dynamic> json) =>
      _$ImprintFromJson(json);
  Map<String, dynamic> toJson() => _$ImprintToJson(this);
}