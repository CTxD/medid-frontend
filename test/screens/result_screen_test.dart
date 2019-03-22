import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/ui/result_screen.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:medid/src/ui/widgets/pill_list.dart';

main() {
  group('Result screen', () {
    testWidgets('has the proper title', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        Widget mqResultScreen = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new ResultScreen()));

        await tester.pumpWidget(mqResultScreen);
        final titleFinder = find.descendant(
            of: find.byType(Scaffold),
            matching: find.byWidgetPredicate((Widget w) =>
                w is AppBar && (w.title as Text).data == "Resultat"));
        expect(titleFinder, findsOneWidget);
      });
    });
    testWidgets('given no match results -> pill list has no match results',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        Widget mqResultScreen = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new ResultScreen(matchResults: [])));

        await tester.pumpWidget(mqResultScreen);
        final plFinder = find.descendant(
            of: find.byType(ResultScreen),
            matching: find.byWidgetPredicate(
                (Widget w) => w is PillList && w.matchResults.isEmpty));
        expect(plFinder, findsOneWidget);
      });
    });
    testWidgets('given match results -> pill list has same match results',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final mockResults = [
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
                home: new ResultScreen(matchResults: mockResults)));

        await tester.pumpWidget(mqResultScreen);
        final plFinder = find.descendant(
            of: find.byType(ResultScreen),
            matching: find.byWidgetPredicate((Widget w) =>
                w is PillList && identical(w.matchResults, mockResults)));
        expect(plFinder, findsOneWidget);
      });
    });
  });
}
