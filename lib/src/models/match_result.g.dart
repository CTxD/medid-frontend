// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchResult _$MatchResultFromJson(Map<String, dynamic> json) {
  return MatchResult(
      probability: (json['probability'] as num)?.toDouble(),
      substance: json['substance'],
      imgstring: json['imgstring'],
      strength: json['strength'],
      name: json['name'],
      kind: json['kind'] as String,
      side: json['side'] as String);
}

Map<String, dynamic> _$MatchResultToJson(MatchResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'substance': instance.substance,
      'imgstring': instance.imgstring,
      'strength': instance.strength,
      'probability': instance.probability,
      'kind': instance.kind,
      'side': instance.side
    };

TestPillRepresentation _$TestPillRepresentationFromJson(
    Map<String, dynamic> json) {
  return TestPillRepresentation(
      width: json['width'] as int,
      height: json['height'] as int,
      imgstring: json['imgstring'] as String,
      imprintid: json['imprintid'] as String);
}

Map<String, dynamic> _$TestPillRepresentationToJson(
        TestPillRepresentation instance) =>
    <String, dynamic>{
      'imgstring': instance.imgstring,
      'imprintid': instance.imprintid,
      'width': instance.width,
      'height': instance.height
    };

SlimPill _$SlimPillFromJson(Map<String, dynamic> json) {
  return SlimPill(
      name: json['name'] as String,
      substance: json['substance'] as String,
      imgstring: json['imgstring'] as String,
      strength: json['strength'] as String);
}

Map<String, dynamic> _$SlimPillToJson(SlimPill instance) => <String, dynamic>{
      'name': instance.name,
      'substance': instance.substance,
      'imgstring': instance.imgstring,
      'strength': instance.strength
    };
