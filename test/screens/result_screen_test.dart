import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/ui/result_screen.dart';
import 'package:image_test_utils/image_test_utils.dart';

main() {
  group('Result screen', () {
    testWidgets('has the proper title', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        Widget mqResultScreen = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new ResultScreen.fromNothing()));

        await tester.pumpWidget(mqResultScreen);
        final titleFinder = find.descendant(
            of: find.byType(Scaffold),
            matching: find.byWidgetPredicate((Widget w) =>
                w is AppBar && (w.title as Text).data == "Resultat"));
        expect(titleFinder, findsOneWidget);
      });
    });
  });
}
