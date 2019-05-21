import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match_result.g.dart';

@JsonSerializable()
class MatchResult extends SlimPill {
  final double probability;

  MatchResult(
      {this.probability = 1,
      activeSubstance,
      pillImageUrl = "http://pro.medicin.dk/resource/media/L58WAN1L?ptype=1",
      strength,
      tradeName})
      : super(
            activeSubstance: activeSubstance,
            pillImageUrl: pillImageUrl,
            strength: strength,
            tradeName: tradeName);
  factory MatchResult.fromJson(Map<String, dynamic> json) =>
      _$MatchResultFromJson(json);
  Map<String, dynamic> toJson() => _$MatchResultToJson(this);
}

@JsonSerializable()
class TestPillRepresentation{
  final String imgstring;
  final String imprintid;
  final int width;
  final int height;
  
  TestPillRepresentation({this.width, this.height, this.imgstring, this.imprintid});

  factory TestPillRepresentation.fromJson(Map<String, dynamic> json) =>
      _$TestPillRepresentationFromJson(json);
  Map<String, dynamic> toJson() => _$TestPillRepresentationToJson(this);
}

@JsonSerializable()
class SlimPill {
  final String tradeName;
  final String activeSubstance;
  final String pillImageUrl;
  final String strength;

  SlimPill(
      {this.tradeName,
      this.activeSubstance,
      this.pillImageUrl =
          "http://pro.medicin.dk/resource/media/L58WAN1L?ptype=1",
      this.strength});

  factory SlimPill.fromJson(Map<String, dynamic> json) =>
      _$SlimPillFromJson(json);
  Map<String, dynamic> toJson() => _$SlimPillToJson(this);
}
