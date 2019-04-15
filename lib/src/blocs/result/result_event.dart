import 'package:equatable/equatable.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ResultEvent extends Equatable {

  ResultEvent([List props = const []]) : super(props);
}

class ResultPageLoaded extends ResultEvent {
  
  final String imageFilePath;
  ResultPageLoaded({this.imageFilePath});
  @override
  String toString() {
    return 'ResultPageLoaded';
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
