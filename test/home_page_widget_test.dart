import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/ui/home_page.dart';
import 'package:medid/src/ui/take_a_picture.dart';
import 'package:medid/src/ui/pill_library.dart';
import 'package:medid/src/ui/info.dart';
import 'package:medid/src/ui/help.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('HomePage tests', () {
    NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<Null> _buildHomePage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomePage(),

        /// This mocked observer will now receive all navigation events
        /// that happen in our app.
        navigatorObservers: [mockObserver],
      ));

      /// The tester.pumpWidget() call above just built our app widget
      /// and triggered the pushObserver method on the mockObserver once.
      verify(mockObserver.didPush(any, any));
    }

    Future<Null> _navigateToTakeAPicture(WidgetTester tester) async {
      /// Tap the button which should navigate to the TakeAPicture Page.
      /// By calling tester.pumpAndSettle(), we ensure that all animations
      /// have completed before we continue further.
      await tester.tap(find.byKey(HomePage.navigateToTakeAPictureButtonKey));
      await tester.pumpAndSettle();
    }

    Future<Null> _navigateToSearchBar(WidgetTester tester) async {
      await tester.tap(find.byKey(HomePage.searchBarKey));
      await tester.pumpAndSettle();
    }

    Future<Null> _navigateToInfo(WidgetTester tester) async {
      await tester.tap(find.byKey(HomePage.navigateToInfoButtonKey));
      await tester.pumpAndSettle();
    }

    Future<Null> _navigateToHelp(WidgetTester tester) async {
      await tester.tap(find.byKey(HomePage.navigateToHelpButtonKey));
      await tester.pumpAndSettle();
    }

    testWidgets(
        'When tapping "take a picture" button, should navigate to TakeAPicture page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _navigateToTakeAPicture(tester);

      // By tapping the button, we should've now navigated to the TakeAPicture
      // page. The didPush() method should've been called...
      verify(mockObserver.didPush(any, any));

      // ...and there should be a TakeAPicture present in the widget tree.
      expect(find.byType(TakeAPicture), findsOneWidget);
    });

    testWidgets(
        'When tapping "pill library" button, should navigate to PillLibrary page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _navigateToSearchBar(tester);

      verify(mockObserver.didPush(any, any));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byKey(Key('SearchScreen')), findsOneWidget);
    });

    testWidgets('When tapping "info" button, should navigate to Info page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _navigateToInfo(tester);

      verify(mockObserver.didPush(any, any));

      expect(find.byType(Info), findsOneWidget);
    });

    testWidgets('When tapping "help" button, should navigate to help page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _navigateToHelp(tester);

      verify(mockObserver.didPush(any, any));

      expect(find.byType(Help), findsOneWidget);
    });

    testWidgets('HomePage renders four buttons', (WidgetTester tester) async {
      await _buildHomePage(tester);
      expect(find.byType(FlatButton), findsNWidgets(4));
    });

    testWidgets('HomePage renders five images', (WidgetTester tester) async {
      await _buildHomePage(tester);
      expect(find.byType(Image), findsNWidgets(5));
    });

    testWidgets('HomePage has five column and three rows',
        (WidgetTester tester) async {
      await _buildHomePage(tester);

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Row), findsNWidgets(3));
      expect(find.byType(Container), findsNWidgets(11));
    });
  });
}
