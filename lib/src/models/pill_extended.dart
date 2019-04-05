import 'package:json_annotation/json_annotation.dart';
import 'package:medid/src/models/match_result.dart';

part 'pill_extended.g.dart';

@JsonSerializable()
class ExtendedPill extends MatchResult {
  ExtendedPill(
      {probability = 1.0,
      activeSubstance,
      pillImageUrl = "http://pro.medicin.dk/resource/media/L58WAN1L?ptype=1",
      strength,
      tradeName})
      : super(
            probability: probability,
            activeSubstance: activeSubstance,
            pillImageUrl: pillImageUrl,
            strength: strength,
            tradeName: tradeName);
  factory ExtendedPill.fromJson(Map<String, dynamic> json) =>
      _$ExtendedPillFromJson(json);
  Map<String, dynamic> toJson() => _$ExtendedPillToJson(this);
}
