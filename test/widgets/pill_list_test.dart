import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/ui/result_screen.dart';
import 'package:image_test_utils/image_test_utils.dart';

main() {
  group('Pill list', () {
    testWidgets('given 5 matchresults, render list with 5 elements',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final n = 5;
        Widget mqResultScreen = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: new ResultScreen(
                    matchResults: List.generate(
                        n,
                        (i) => MatchResult(
                            title: 'Title $i',
                            activeSubstance: 'Active Substance $i')))));
        await tester.pumpWidget(mqResultScreen);

        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(Card), findsNWidgets(n));
      });
    });

    testWidgets('given 0 matchresults, render list with 0 elements',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        final n = 0;
        Widget mqResultScreen = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: new ResultScreen(
                    matchResults: List.generate(
                        n,
                        (i) => MatchResult(
                            title: 'Title $i',
                            activeSubstance: 'Active Substance $i')))));
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
          MatchResult(title: 'Panodil', activeSubstance: 'Coffein'),
          MatchResult(title: 'Viagra', activeSubstance: 'Water'),
          MatchResult(title: 'Amphetamine', activeSubstance: 'N/A'),
        ];
        Widget mqResultScreen = new MediaQuery(
            data: new MediaQueryData(),
            child:
                new MaterialApp(home: new ResultScreen(matchResults: results)));
        await tester.pumpWidget(mqResultScreen);

        results.forEach((mr) {
          final k = Key(results.indexOf(mr).toString());
          final c = tester.widget<Card>(find.byKey(k));
          final lt = c.child as ListTile;
          expect((lt.title as Text).data, mr.title);
          expect((lt.subtitle as Text).data, mr.activeSubstance);
          expect(
              find.descendant(
                  of: find.byWidget(lt),
                  matching: find.byWidgetPredicate((Widget w) =>
                      w is SizedBox &&
                      w.height == 100 &&
                      w.width == 100 &&
                      w.child is Image)),
              findsOneWidget);
        });
      });
    });
  });
}
