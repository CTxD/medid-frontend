import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/blocs/result/bloc.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:medid/src/ui/pill_info_screen.dart';
import 'package:medid/src/ui/widgets/pill_list.dart';
import 'package:mockito/mockito.dart';

class ResultBlocMock extends Mock implements ResultBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
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
                name: 'tradeName $i',
                substance: 'Active Substance $i',
                strength: i.toString()));
        Widget pillList = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: new PillList(
              resultBloc: blocMock,
            )));

        when(blocMock.currentState)
            .thenAnswer((_) => FoundMatches(results: nResults));
        await tester.pumpWidget(pillList);
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
                name: 'tradeName $i',
                substance: 'Active Substance $i',
                strength: i.toString()));
        Widget pillList = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: new PillList(
              resultBloc: blocMock,
            )));

        when(blocMock.currentState)
            .thenAnswer((_) => FoundMatches(results: nResults));
        await tester.pumpWidget(pillList);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(Card), findsNWidgets(n));
      });
    });

    testWidgets(
        'render each match result appropriately with tradeName, active substance, and image',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final List<MatchResult> results = [
          MatchResult(
              name: 'Panodil', strength: '20mg', substance: 'Coffein'),
          MatchResult(
              name: 'Viagra', strength: '10mg', substance: 'Water'),
          MatchResult(
              name: 'Amphetamine', strength: '1kg', substance: 'N/A'),
        ];
        Widget pillList = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: new PillList(
              resultBloc: blocMock,
            )));
        when(blocMock.currentState)
            .thenAnswer((_) => FoundMatches(results: results));
        await tester.pumpWidget(pillList);

        results.forEach((mr) {
          final k = Key(results.indexOf(mr).toString());
          final c = tester.widget<Card>(find.byKey(k));
          final lt = c.child as ListTile;
          expect((lt.title as Text)?.data, mr.name + "  " + mr.strength);
          expect((lt.subtitle as Text)?.data, mr.substance);

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

    testWidgets('renders loading indicator if in loading state',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      Widget pillList = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              navigatorObservers: [mockObserver],
              home: new PillList(
                resultBloc: blocMock,
              )));
      when(blocMock.currentState).thenAnswer((_) => LoadingMatches());
      await tester.pumpWidget(pillList);
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });



    testWidgets(
        'taps element -> navigate to pill info screen -> pop pill info leads to dispatch of event',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final mockObserver = MockNavigatorObserver();
        final List<MatchResult> results = [
          MatchResult(
              name: 'Panodil', strength: '20mg', substance: 'Coffein'),
          MatchResult(
              name: 'Viagra', strength: '10mg', substance: 'Water'),
          MatchResult(
              name: 'Amphetamine', strength: '1kg', substance: 'N/A'),
        ];
        Widget pillList = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                navigatorObservers: [mockObserver],
                home: new PillList(
                  resultBloc: blocMock,
                )));
        when(blocMock.currentState)
            .thenAnswer((_) => FoundMatches(results: results));
        await tester.pumpWidget(pillList);

        final pillToView = results[1];

        await tester.tap(find.byWidgetPredicate((w) =>
            w is ListTile &&
            identical((w.subtitle as Text).data, pillToView.substance)));
        when(blocMock.currentState)
            .thenAnswer((_) => ShowPillInfo(pillInfo: results[1]));
        await tester.pumpAndSettle();

        /// Verify that a push event happened
        verify(mockObserver.didPush(any, any));

        /// You'd also want to be sure that your page is now
        /// present in the screen.
        expect(
            find.byWidgetPredicate((w) => w is PillInfoPage), findsOneWidget);
        await tester.pageBack();
        await tester.pumpAndSettle();
        verify(blocMock.dispatch(ResultPageLoaded())).called(1);
      });
    });
  });
}

