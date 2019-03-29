import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class ResultState extends Equatable {
  ResultState([List props = const []]) : super(props);
}

class InitialResultState extends ResultState {}

class LoadingMatches extends ResultState {
  @override
  String toString() {
    return 'LoadingMatches';
  }
}

class FoundMatches extends ResultState {
  final List<MatchResult> results;

  FoundMatches({@required this.results}) : super([results]);
  @override
  String toString() {
    return 'FoundMatches { results: $results }';
  }
}

class ShowPillInfo extends ResultState {
  final MatchResult pillInfo;

  ShowPillInfo({@required this.pillInfo}) : super([pillInfo]);
  @override
  String toString() {
    return 'ShowPillInfo { results: $pillInfo }';
  }
}
