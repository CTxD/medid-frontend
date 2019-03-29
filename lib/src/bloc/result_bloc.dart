import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:medid/src/models/match_result.dart';
import './bloc.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final FeatureExtractor fx;

  ResultBloc({this.fx});
  @override
  ResultState get initialState => LoadingMatches();
  @override
  Stream<ResultState> mapEventToState(
    ResultEvent event,
  ) async* {
    if (event is MatchClicked) {
      yield ShowPillInfo(pillInfo: event.clickedMr);
    }
    if (event is ResultPageLoaded) {
      await Future.delayed(const Duration(seconds: 1));
      yield FoundMatches(results: fx.getMatches());
    }
  }
}

class FeatureExtractor {
  List<MatchResult> getMatches() {
    return [
      MatchResult(
          title: 'Panodil', strength: '20mg', activeSubstance: 'Coffein'),
      MatchResult(title: 'Viagra', strength: '10mg', activeSubstance: 'Water'),
      MatchResult(
          title: 'Amphetamine', strength: '1kg', activeSubstance: 'N/A'),
    ];
  }
}
