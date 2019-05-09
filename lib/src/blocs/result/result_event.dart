import 'package:equatable/equatable.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ResultEvent extends Equatable {
  ResultEvent([List props = const []]) : super(props);
}

class ResultPageLoaded extends ResultEvent {
  final String imageFilePath;
  final Future<String> imprintsJson;

  ResultPageLoaded({this.imageFilePath, this.imprintsJson});
  @override
  String toString() {
    return 'ResultPageLoaded { imageFilePath: $imageFilePath , imprintsJson: $imprintsJson }';
  }
}

class UserInitRecog extends ResultEvent {
  final String imageFilePath;
  final String imprint;
  UserInitRecog({this.imageFilePath, this.imprint});
  @override
  String toString() {
    return 'UserInitRecog';
  }
}

class ChosenImprint extends ResultEvent {
  final String imprint;
  ChosenImprint({this.imprint});
  @override
  String toString() {
    return 'ChosenImprint';
  }
}

class MatchClicked extends ResultEvent {
  final MatchResult clickedMr;

  MatchClicked({@required this.clickedMr}) : super([clickedMr]);

  @override
  String toString() {
    return 'MatchClicked { clicked: $clickedMr }';
  }
}
