import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/bloc/bloc.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:medid/src/ui/pill_info_screen.dart';
import 'package:medid/src/ui/widgets/pill_list.dart';
import 'package:mockito/mockito.dart';

class ResultBlocMock extends Mock implements ResultBloc {}

class FeatureExtractorMock extends Mock implements FeatureExtractor {}

main() {
  group('Pill list', () {
    ResultBloc blocMock;
    setUp(() {
      blocMock = ResultBlocMock();
    });
    testWidgets('given 5 matchresults, render list with 5 elements',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final n = 5;
        final nResults = List.generate(
            n,
            (i) => MatchResult(
                title: 'Title $i',
                activeSubstance: 'Active Substance $i',
                strength: i.toString()));
        Widget mqResultScreen = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: new PillList(
              resultBloc: blocMock,
            )));

        when(blocMock.currentState)
            .thenAnswer((_) => FoundMatches(results: nResults));
        await tester.pumpWidget(mqResultScreen);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(Card), findsNWidgets(n));
      });
    });

    testWidgets('given 0 matchresults, render list with 0 elements',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final n = 0;
        final nResults = List.generate(
            n,
            (i) => MatchResult(
                title: 'Title $i',
                activeSubstance: 'Active Substance $i',
                strength: i.toString()));
        Widget mqResultScreen = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: new PillList(
              resultBloc: blocMock,
            )));

        when(blocMock.currentState)
            .thenAnswer((_) => FoundMatches(results: nResults));
        await tester.pumpWidget(mqResultScreen);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(Card), findsNWidgets(n));
      });
    });

    testWidgets(
        'render each match result appropriately with title, active substance, and image',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final List<MatchResult> results = [
          MatchResult(
              title: 'Panodil', strength: '20mg', activeSubstance: 'Coffein'),
          MatchResult(
              title: 'Viagra', strength: '10mg', activeSubstance: 'Water'),
          MatchResult(
              title: 'Amphetamine', strength: '1kg', activeSubstance: 'N/A'),
        ];
        Widget mqResultScreen = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: new PillList(
              resultBloc: blocMock,
            )));
        when(blocMock.currentState)
            .thenAnswer((_) => FoundMatches(results: results));
        await tester.pumpWidget(mqResultScreen);

        results.forEach((mr) {
          final k = Key(results.indexOf(mr).toString());
          final c = tester.widget<Card>(find.byKey(k));
          final lt = c.child as ListTile;
          expect((lt.title as Text)?.data, mr.title + "  " + mr.strength);
          expect((lt.subtitle as Text)?.data, mr.activeSubstance);

          final imageFinder = find.descendant(
              of: find.byWidget(lt),
              matching: find.byWidgetPredicate((Widget w) =>
                  w is SizedBox &&
                  w.height == 100 &&
                  w.width == 100 &&
                  w.child is Image));
          expect(imageFinder, findsOneWidget);
          expect(
            tester.widget(imageFinder),
            lt.leading,
          );
        });
      });
    });

    testWidgets('taps element -> navigate to pill info screen',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final mockObserver = MockNavigatorObserver();
        final List<MatchResult> results = [
          MatchResult(
              title: 'Panodil', strength: '20mg', activeSubstance: 'Coffein'),
          MatchResult(
              title: 'Viagra', strength: '10mg', activeSubstance: 'Water'),
          MatchResult(
              title: 'Amphetamine', strength: '1kg', activeSubstance: 'N/A'),
        ];
        Widget mqResultScreen = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                navigatorObservers: [mockObserver],
                home: new PillList(
                  resultBloc: blocMock,
                )));
        when(blocMock.currentState)
            .thenAnswer((_) => FoundMatches(results: results));
        await tester.pumpWidget(mqResultScreen);

        final pillToView = results[1];

        await tester.tap(find.byWidgetPredicate((w) =>
            w is ListTile &&
            identical((w.subtitle as Text).data, pillToView.activeSubstance)));
        when(blocMock.currentState)
            .thenAnswer((_) => ShowPillInfo(pillInfo: results[1]));
        await tester.pumpAndSettle();

        /// Verify that a push event happened
        verify(mockObserver.didPush(any, any));

        /// You'd also want to be sure that your page is now
        /// present in the screen.
        expect(
            find.byWidgetPredicate((w) => w is PillInfoPage), findsOneWidget);
      });
    });
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
