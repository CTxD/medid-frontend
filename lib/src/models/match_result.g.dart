// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchResult _$MatchResultFromJson(Map<String, dynamic> json) {
  return MatchResult(
      probability: (json['probability'] as num)?.toDouble(),
      activeSubstance: json['activeSubstance'],
      pillImageUrl: json['pillImageUrl'],
      strength: json['strength'],
      tradeName: json['tradeName']);
}

Map<String, dynamic> _$MatchResultToJson(MatchResult instance) =>
    <String, dynamic>{
      'tradeName': instance.tradeName,
      'activeSubstance': instance.activeSubstance,
      'pillImageUrl': instance.pillImageUrl,
      'strength': instance.strength,
      'probability': instance.probability
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
      tradeName: json['tradeName'] as String,
      activeSubstance: json['activeSubstance'] as String,
      pillImageUrl: json['pillImageUrl'] as String,
      strength: json['strength'] as String);
}

Map<String, dynamic> _$SlimPillToJson(SlimPill instance) => <String, dynamic>{
      'tradeName': instance.tradeName,
      'activeSubstance': instance.activeSubstance,
      'pillImageUrl': instance.pillImageUrl,
      'strength': instance.strength
    };
