import 'package:medid/src/bloc/bloc.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class PillIdentifierMock extends Mock implements PillIdentifier {}

void main() {
  group('ResultBloc', () {
    ResultBloc resultBloc;
    PillIdentifierMock _piMock;

    setUp(() {
      _piMock = PillIdentifierMock();
      resultBloc = ResultBloc(pi: _piMock);
    });
    test('initial state is correct', () {
      expect(LoadingMatches(), resultBloc.initialState);
    });
    test(
        'emits loading state followed by foundmatches state when an obj of "ResultPageLoaded" is dispatched',
        () {
      when(_piMock.getMatches()).thenReturn([]);
      expectLater(resultBloc.state,
          emitsInOrder([resultBloc.initialState, FoundMatches(results: [])]));
      resultBloc.dispatch(ResultPageLoaded());
    });
    test('emits ShowPillInfo when an obj of "MatchClicked" is dispatched', () {
      final clickedMr = MatchResult();

      expectLater(
          resultBloc.state,
          emitsInOrder(
              [resultBloc.initialState, ShowPillInfo(pillInfo: clickedMr)]));
      resultBloc.dispatch(MatchClicked(clickedMr: clickedMr));
    });
  });
  group('ResultEvent', () {
    test(' ".toStrings"   ', () {
      final mr = MatchResult(
          title: 'Panodil', strength: '20mg', activeSubstance: 'Coffein');
      final MatchClicked cm = MatchClicked(clickedMr: mr);

      expect(cm.toString(), 'MatchClicked { clicked: $mr }');
      expect(ResultPageLoaded().toString(), 'ResultPageLoaded');
    });
  });
  group('ResultState', () {
    test(' ".toStrings"   ', () {
      final mr = MatchResult(
          title: 'Panodil', strength: '20mg', activeSubstance: 'Coffein');
      final MatchClicked cm = MatchClicked(clickedMr: mr);
      final List<MatchResult> e = [];

      expect(LoadingMatches().toString(), 'LoadingMatches');

      expect(
          FoundMatches(results: e).toString(), 'FoundMatches { results: $e }');
      expect(ShowPillInfo(pillInfo: mr).toString(),
          'ShowPillInfo { pillInfo: $mr }');
    });
  });
}
