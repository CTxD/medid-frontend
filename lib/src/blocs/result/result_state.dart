import 'dart:typed_data';
import 'dart:ui';

import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class ResultState extends Equatable {
  ResultState(this.imageFilePath, [List props = const []]) : super(props);
  final String imageFilePath;
}

class LoadingMatches extends ResultState {
  LoadingMatches({String imageFilePath}) : super(imageFilePath);

  @override
  String toString() {
    return 'LoadingMatches';
  }
}

class MatchingError extends ResultState {
  final error;
  MatchingError({String imageFilePath, this.error}) : super(imageFilePath);
  @override
  String toString() {
    return 'MatchingError';
  }
}

class ShowPillInfoError extends ResultState {
  ShowPillInfoError({String imageFilePath}) : super(imageFilePath);
  @override
  String toString() {
    return 'ShowPillInfoError';
  }
}

class FoundMatches extends ResultState {
  final List<MatchResult> results;
  final String imprint;

  FoundMatches({@required this.results, String imageFilePath, this.imprint})
      : super(imageFilePath, [results]);
  @override
  String toString() {
    return 'FoundMatches { results: $results }';
  }
}

class UserSelectImprint extends ResultState {
  UserSelectImprint({String imageFilePath, this.imprints})
      : super(imageFilePath);

  final Map<String, Uint8List> imprints;

  @override
  String toString() {
    return 'UserSelectImprint';
  }
}

class SelectedImprint extends UserSelectImprint {
  final String chosenImprint;
  final Map<String, Uint8List> imprints;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedImprint &&
          runtimeType == other.runtimeType &&
          chosenImprint == other.chosenImprint;

  @override
  int get hashCode => chosenImprint.hashCode;

  SelectedImprint({this.chosenImprint, this.imprints, String imageFilePath})
      : super(imageFilePath: imageFilePath);
}

class ShowPillInfo extends ResultState {
  final MatchResult pillInfo;

  ShowPillInfo({@required this.pillInfo, String imageFilePath})
      : super(imageFilePath, [pillInfo]);
  @override
  String toString() {
    return 'ShowPillInfo { pillInfo: $pillInfo }';
  }
}
