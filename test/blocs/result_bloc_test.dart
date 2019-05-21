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
      resultBloc =
          ResultBloc(createFile: (s) => null, pillRepository: pillRepository);
    });
    test('initial state is correct', () {
      expect(LoadingMatches(), resultBloc.initialState);
    });
    test(
        'emits [LoadingMatches, FoundMatches] when pill repository returns matches',
        () {
      final String testJson = '{\n"0": "iVBjdW1lbnRJRD0JRU5ErkJggg=="\n}';
      final List<MatchResult> results = [
        MatchResult(
            name: 'Panodil', strength: '20mg', substance: 'Coffein'),
        MatchResult(
            name: 'Viagra', strength: '10mg', substance: 'Water'),
        MatchResult(
            name: 'Amphetamine', strength: '1kg', substance: 'N/A'),
      ];
      when(pillRepository.identifyPill(null, '2'))
          .thenAnswer((_) => Future.value(results));
      expectLater(resultBloc.state,
          emitsInOrder([LoadingMatches(), UserSelectImprint()]));
      resultBloc.dispatch(ResultPageLoaded(
          imageFilePath: 'TestPath', imprintsJson: Future.value(testJson)));
    });

    test(
        'emits [LoadingMatches, ResultError] when pill repository throws error',
        () {
      final String testJson = '{\n"0": "iVBjdW1lbnRJRD0JRU5ErkJggg=="\n}';
      when(pillRepository.identifyPill(null, '2')).thenThrow('Matching error');

      expectLater(
          resultBloc.state,
          emitsInOrder([
            LoadingMatches(),
            UserSelectImprint(),
            LoadingMatches(),
            MatchingError()
          ]));

      resultBloc
          .dispatch(ResultPageLoaded(imprintsJson: Future.value(testJson)));
      resultBloc.dispatch(UserInitRecog(imprint: '2'));
    });

    test(
        'emits [LoadingMatches, ResultError, LoadingMatches, ResultError] when pill repository throws error twice',
        () {
      final String testJson = '{\n"0": "iVBjdW1lbnRJRD0JRU5ErkJggg=="\n}';
      when(pillRepository.identifyPill(null, '2')).thenThrow('Matching error');

      expectLater(
          resultBloc.state,
          emitsInOrder([
            LoadingMatches(),
            UserSelectImprint(),
            LoadingMatches(),
            MatchingError(),
            UserSelectImprint(),
            LoadingMatches(),
            MatchingError()
          ]));

      resultBloc
          .dispatch(ResultPageLoaded(imprintsJson: Future.value(testJson)));
      resultBloc.dispatch(UserInitRecog(imprint: '2'));
      resultBloc
          .dispatch(ResultPageLoaded(imprintsJson: Future.value(testJson)));
      resultBloc.dispatch(UserInitRecog(imprint: '2'));
    });

    test(
        'emits [LoadingMatches, ShowPillInfo] when an obj of "MatchClicked" is dispatched and repository returns extended pill',
        () {
      final clickedMr = MatchResult(
          name: 'Panodil', strength: '20mg', substance: 'Coffein');
      final extendedPill = ExtendedPill();

      when(pillRepository.getExtendedPill(clickedMr.name))
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
          name: 'Panodil', strength: '20mg', substance: 'Coffein');

      when(pillRepository.getExtendedPill(clickedMr.name))
          .thenThrow('ShowPillInfo error ');
      expectLater(resultBloc.state,
          emitsInOrder([LoadingMatches(), ShowPillInfoError()]));
      resultBloc.dispatch(MatchClicked(clickedMr: clickedMr));
    });
  });

  group('ResultEvent', () {
    test(' ".toStrings"   ', () {
      final mr = MatchResult(
          name: 'Panodil', strength: '20mg', substance: 'Coffein');
      final MatchClicked cm = MatchClicked(clickedMr: mr);

      expect(cm.toString(), 'MatchClicked { clicked: $mr }');
      final tJson = Future.value('');
      expect(
          ResultPageLoaded(imageFilePath: 'path', imprintsJson: tJson)
              .toString(),
          'ResultPageLoaded { imageFilePath: path , imprintsJson: ${tJson.toString()} }');
    });
  });
  group('ResultState', () {
    test(' ".toStrings"   ', () {
      final mr = MatchResult(
          name: 'Panodil', strength: '20mg', substance: 'Coffein');
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
