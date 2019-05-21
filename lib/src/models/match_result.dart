import 'package:json_annotation/json_annotation.dart';

part 'match_result.g.dart';

@JsonSerializable()
class MatchResult extends SlimPill {
  final double probability;
  final String kind;
  final String side;

  MatchResult(
      {this.probability,
      substance,
      imgstring,
      strength,
      name,
      this.kind,
      this.side})
      : super(
            substance: substance,
            imgstring: imgstring,
            strength: strength,
            name: name);


  
  factory MatchResult.fromJson(Map<String, dynamic> json) =>
      _$MatchResultFromJson(json);
  Map<String, dynamic> toJson() => _$MatchResultToJson(this);
}

          /*'probability': self.probability,
            'imgstring': self.imgstring.decode('UTF-8'),
            'name': self.pillfeature['name'],
            'side': self.pillfeature['side'],
            'substance': self.substance,
            'kind': self.pillfeature['kind'],
            'strength': self.pillfeature['strength'],*/

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
  final String name;
  final String substance;
  final String imgstring;
  final String strength;

  SlimPill(
      {this.name,
      this.substance,
      this.imgstring =
          "http://pro.medicin.dk/resource/media/L58WAN1L?ptype=1",
      this.strength});

  factory SlimPill.fromJson(Map<String, dynamic> json) =>
      _$SlimPillFromJson(json);
  Map<String, dynamic> toJson() => _$SlimPillToJson(this);
}
