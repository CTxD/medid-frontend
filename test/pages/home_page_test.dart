import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/ui/help_page.dart';
import 'package:medid/src/ui/home_page.dart';
import 'package:medid/src/ui/cam_page.dart';
import 'package:medid/src/ui/info_page.dart';
import 'package:medid/src/ui/pill_library_page.dart';
import 'package:medid/src/ui/widgets/home_button.dart';
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

    Future<Null> _tapByKeyAndSettle(WidgetTester tester, Key key) async {
      /// Tap the button which should navigate to the TakeAPicture Page.
      /// By calling tester.pumpAndSettle(), we ensure that all animations
      /// have completed before we continue further.
      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
    }

    testWidgets(
        'When tapping "take a picture" button, should navigate to TakeAPicture page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _tapByKeyAndSettle(tester, HomePage.camPageButtonKey);

      // By tapping the button, we should've now navigated to the TakeAPicture
      // page. The didPush() method should've been called...
      verify(mockObserver.didPush(any, any));

      // ...and there should be a TakeAPicture present in the widget tree.
      expect(find.byType(CamPage), findsOneWidget);
    });

    testWidgets(
        'When tapping "pill library" button, should navigate to PillLibrary page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _tapByKeyAndSettle(tester, HomePage.pillLibButtonKey);

      verify(mockObserver.didPush(any, any));

      expect(find.byType(PillLibraryPage), findsOneWidget);
    });

    testWidgets('When tapping "info" button, should navigate to Info page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _tapByKeyAndSettle(tester, HomePage.infoPageButtonKey);

      verify(mockObserver.didPush(any, any));

      expect(find.byType(InfoPage), findsOneWidget);
    });

    testWidgets('When tapping "help" button, should navigate to help page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _tapByKeyAndSettle(tester, HomePage.helpPageButtonKey);

      verify(mockObserver.didPush(any, any));

      expect(find.byType(HelpPage), findsOneWidget);
    });
    testWidgets('renders logo on top', (WidgetTester tester) async {
      await _buildHomePage(tester);

      final Scaffold scf = tester.widget(find.byType(Scaffold));
      final Container rootContainer = tester.widget(
          find.byWidgetPredicate((w) => w is Container && scf.body == w));
      expect(find.byWidget(rootContainer), findsOneWidget);
      expect(rootContainer.child.runtimeType, Column);
      final Column outerColumn = rootContainer.child;
      final firstElementFinder = find.descendant(
          of: find.byWidget(outerColumn),
          matching: find.byWidgetPredicate(
              (w) => w is Row && outerColumn.children.first == w));
              
      expect(firstElementFinder, findsOneWidget);
      final imageFinder =
          find.descendant(of: firstElementFinder, matching: find.byType(Image));
      expect(imageFinder, findsOneWidget);
      final Image image = tester.widget(imageFinder);
      expect(image.image, Image.asset('images/medid_logo.png').image);
    });

    testWidgets('supplies correct info to the 4 buttons',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      expect(find.byType(HomeButton), findsNWidgets(4));
      final expectCorrectLayout = ({HomeButton b, i, height, imageWidth}) {
        expect(b.imagePath, i);
        expect(b.height, height);
        expect(b.imageWidth, imageWidth);
      };
      expectCorrectLayout(
          b: tester.widget(find.byKey(HomePage.camPageButtonKey)),
          i: 'images/photo.png',
          height: 150,
          imageWidth: 70);
      expectCorrectLayout(
          b: tester.widget(find.byKey(HomePage.pillLibButtonKey)),
          i: 'images/list.png',
          height: 150,
          imageWidth: 55);
      expectCorrectLayout(
          b: tester.widget(find.byKey(HomePage.infoPageButtonKey)),
          i: 'images/info.png',
          height: 100,
          imageWidth: 35);
      expectCorrectLayout(
          b: tester.widget(find.byKey(HomePage.helpPageButtonKey)),
          i: 'images/help.png',
          height: 100,
          imageWidth: 35);
    });

    testWidgets('renders the correct five images', (WidgetTester tester) async {
      await _buildHomePage(tester);
      expect(find.byType(Image), findsNWidgets(5));
      final imageMatcher =
          (Image i) => (Widget w) => w is Image && w.image == i.image;
      expect(
          find.byWidgetPredicate(
              imageMatcher(Image.asset('images/medid_logo.png'))),
          findsOneWidget);
      expect(
          find.byWidgetPredicate(imageMatcher(Image.asset('images/photo.png'))),
          findsOneWidget);
      expect(
          find.byWidgetPredicate(imageMatcher(Image.asset('images/list.png'))),
          findsOneWidget);
      expect(
          find.byWidgetPredicate(imageMatcher(Image.asset('images/help.png'))),
          findsOneWidget);
      expect(
          find.byWidgetPredicate(imageMatcher(Image.asset('images/info.png'))),
          findsOneWidget);
    });
  });
}
