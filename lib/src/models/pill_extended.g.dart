// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill_extended.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendedPill _$ExtendedPillFromJson(Map<String, dynamic> json) {
  return ExtendedPill(
      probability: json['probability'],
      substance: json['substance'],
      imgstring: json['imgstring'],
      strength: json['strength'],
      name: json['name']);
}

Map<String, dynamic> _$ExtendedPillToJson(ExtendedPill instance) =>
    <String, dynamic>{
      'name': instance.name,
      'substance': instance.substance,
      'imgstring': instance.imgstring,
      'strength': instance.strength,
      'probability': instance.probability
    };
