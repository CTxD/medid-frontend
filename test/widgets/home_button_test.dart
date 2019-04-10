import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/ui/info_page.dart';
import 'package:medid/src/ui/widgets/home_button.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('HomeButton tests', () {
    NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<Null> _tapByKeyAndSettle(WidgetTester tester, Key key) async {
      /// Tap the button which should navigate to the TakeAPicture Page.
      /// By calling tester.pumpAndSettle(), we ensure that all animations
      /// have completed before we continue further.
      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
    }

    testWidgets('button layout and navigation should work',
        (WidgetTester tester) async {
      final hpb = HomeButton(
        imagePath: 'images/medid_logo.png',
        imageWidth: 100,
        height: 100,
        key: Key("..."),
        page: InfoPage(),
      );
      await tester.pumpWidget(MaterialApp(
        home: Row(children: [hpb]),
        navigatorObservers: [mockObserver],
      ));
      expect(find.byType(HomeButton), findsOneWidget);

      // Layout
      final containerFinder = find.descendant(
          of: find.byType(Expanded),
          matching: find.byWidgetPredicate(
              (w) => w is Container && w.child.runtimeType == FlatButton));
      expect(containerFinder, findsOneWidget);
      
      expect(
          find.descendant(
              of: containerFinder,
              matching: find.byWidgetPredicate((w) =>
                  w is FlatButton &&
                  w.color == Colors.white &&
                  w.child is Image &&
                  (w.child as Image).height == 100 &&
                  (w.child as Image).width == 100 &&
                  (w.child as Image).image ==
                      Image.asset('images/medid_logo.png').image)),
          findsOneWidget);
      // Navigation
      await _tapByKeyAndSettle(tester, Key("..."));
      verify(mockObserver.didPush(any, any));
      expect(find.byType(InfoPage), findsOneWidget);
    });
  });
}
