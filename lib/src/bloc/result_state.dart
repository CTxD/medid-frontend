import 'dart:ui';

import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class ResultState extends Equatable {
  ResultState(this.image, [List props = const []]) : super(props);
  final Image image;
}

class InitialResultState extends ResultState {
  InitialResultState({Image image}) : super(image);
}

class LoadingMatches extends ResultState {
  LoadingMatches({Image image}) : super(image);

  @override
  String toString() {
    return 'LoadingMatches';
  }
}

class MatchingError extends ResultState {
  MatchingError({Image image}) : super(image);
  @override
  String toString() {
    return 'MatchingError';
  }
}

class ShowPillInfoError extends ResultState {
  ShowPillInfoError({Image image}) : super(image);
  @override
  String toString() {
    return 'ShowPillInfoError';
  }
}

class FoundMatches extends ResultState {
  final List<MatchResult> results;

  FoundMatches({@required this.results, Image image}) : super(image, [results]);
  @override
  String toString() {
    return 'FoundMatches { results: $results }';
  }
}

class ShowPillInfo extends ResultState {
  final MatchResult pillInfo;

  ShowPillInfo({@required this.pillInfo, Image image})
      : super(image, [pillInfo]);
  @override
  String toString() {
    return 'ShowPillInfo { pillInfo: $pillInfo }';
  }
}
