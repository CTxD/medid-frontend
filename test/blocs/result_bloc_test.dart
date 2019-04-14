import 'dart:io';

import 'package:medid/src/blocs/result/bloc.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';
import 'package:medid/src/repositories/pill_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class PillRepositoryMock extends Mock implements PillRepository {}

void main() {
  group('ResultBloc', () {
    ResultBloc resultBloc;
    PillRepositoryMock pillRepository;

    setUp(() {
      pillRepository = PillRepositoryMock();
      resultBloc = ResultBloc(createFile: (s) => null, pillRepository: pillRepository);
    });
    test('initial state is correct', () {
      expect(LoadingMatches(), resultBloc.initialState);
    });
    test(
        'emits [LoadingMatches, FoundMatches] when pill repository returns matches',
        () {
      final List<MatchResult> results = [
        MatchResult(
            tradeName: 'Panodil', strength: '20mg', activeSubstance: 'Coffein'),
        MatchResult(
            tradeName: 'Viagra', strength: '10mg', activeSubstance: 'Water'),
        MatchResult(
            tradeName: 'Amphetamine', strength: '1kg', activeSubstance: 'N/A'),
      ];
      when(pillRepository.identifyPill(null)).thenAnswer((_) => Future.value(results));
      expectLater(resultBloc.state,
          emitsInOrder([LoadingMatches(), FoundMatches(results: results)]));
      resultBloc.dispatch(ResultPageLoaded(imageFilePath: 'TestPath'));
    });

    test(
        'emits [LoadingMatches, ResultError] when pill repository throws error',
        () {
      when(pillRepository.identifyPill(null)).thenThrow('Matching error');
      expectLater(
          resultBloc.state, emitsInOrder([LoadingMatches(), MatchingError()]));

      resultBloc.dispatch(ResultPageLoaded());
    });

    test(
        'emits [LoadingMatches, ShowPillInfo] when an obj of "MatchClicked" is dispatched and repository returns extended pill',
        () {
      final clickedMr = MatchResult(
          tradeName: 'Panodil', strength: '20mg', activeSubstance: 'Coffein');
      final extendedPill = ExtendedPill();

      when(pillRepository.getExtendedPill(clickedMr.tradeName))
          .thenAnswer((_) => Future.value(extendedPill));
      expectLater(
          resultBloc.state,
          emitsInOrder(
              [LoadingMatches(), ShowPillInfo(pillInfo: extendedPill)]));
      resultBloc.dispatch(MatchClicked(clickedMr: clickedMr));
    });
    test(
        'emits [LoadingMatches, ShowPillInfoError] when an obj of "MatchClicked" is dispatched and repository throws error',
        () {
      final clickedMr = MatchResult(
          tradeName: 'Panodil', strength: '20mg', activeSubstance: 'Coffein');

      when(pillRepository.getExtendedPill(clickedMr.tradeName))
          .thenThrow('ShowPillInfo error ');
      expectLater(resultBloc.state,
          emitsInOrder([LoadingMatches(), ShowPillInfoError()]));
      resultBloc.dispatch(MatchClicked(clickedMr: clickedMr));
    });
  });

  group('ResultEvent', () {
    test(' ".toStrings"   ', () {
      final mr = MatchResult(
          tradeName: 'Panodil', strength: '20mg', activeSubstance: 'Coffein');
      final MatchClicked cm = MatchClicked(clickedMr: mr);

      expect(cm.toString(), 'MatchClicked { clicked: $mr }');
      expect(ResultPageLoaded().toString(), 'ResultPageLoaded');
    });
  });
  group('ResultState', () {
    test(' ".toStrings"   ', () {
      final mr = MatchResult(
          tradeName: 'Panodil', strength: '20mg', activeSubstance: 'Coffein');
      final MatchClicked cm = MatchClicked(clickedMr: mr);
      final List<MatchResult> e = [];

      expect(LoadingMatches(imageFilePath: null).toString(), 'LoadingMatches');

      expect(
          FoundMatches(results: e).toString(), 'FoundMatches { results: $e }');
      expect(ShowPillInfo(pillInfo: mr).toString(),
          'ShowPillInfo { pillInfo: $mr }');
    });
  });
}
