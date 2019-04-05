// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill_extended.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendedPill _$ExtendedPillFromJson(Map<String, dynamic> json) {
  return ExtendedPill(
      probability: json['probability'],
      activeSubstance: json['activeSubstance'],
      pillImageUrl: json['pillImageUrl'],
      strength: json['strength'],
      tradeName: json['tradeName']);
}

Map<String, dynamic> _$ExtendedPillToJson(ExtendedPill instance) =>
    <String, dynamic>{
      'tradeName': instance.tradeName,
      'activeSubstance': instance.activeSubstance,
      'pillImageUrl': instance.pillImageUrl,
      'strength': instance.strength,
      'probability': instance.probability
    };
