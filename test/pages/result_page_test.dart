import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/bloc/bloc.dart';
import 'package:medid/src/ui/result_page.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:medid/src/ui/widgets/pill_list.dart';
import 'package:mockito/mockito.dart';

class ResultBlocMock extends Mock implements ResultBloc {}

main() {
  group('Result screen', () {
    ResultBloc blocMock;
    Widget mqResultPage;
    setUp(() {
      blocMock = ResultBlocMock();
      mqResultPage = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new ResultPage(resultBloc: blocMock)));
    });
    testWidgets('has the proper title', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {

        when(blocMock.currentState)
            .thenAnswer((_) => FoundMatches(results: []));
        await tester.pumpWidget(mqResultPage);
        final titleFinder = find.descendant(
            of: find.byType(Scaffold),
            matching: find.byWidgetPredicate((Widget w) =>
                w is AppBar && (w.title as Text).data == "Resultat"));
        expect(titleFinder, findsOneWidget);
      });
    });
    testWidgets('renders a pill list as body', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {

        when(blocMock.currentState)
            .thenAnswer((_) => FoundMatches(results: []));
        await tester.pumpWidget(mqResultPage);

        expect(
            find.byWidgetPredicate(
                (w) => w is Scaffold && w.body.runtimeType == PillList),
            findsOneWidget);
      });
    });
    testWidgets('shows a loading indicator while loading',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {

        when(blocMock.currentState).thenAnswer((_) => LoadingMatches());
        await tester.pumpWidget(mqResultPage);

        expect(
            find.byWidgetPredicate((w) =>
                w is Scaffold &&
                w.body.runtimeType == Center &&
                (w.body as Center).child.runtimeType ==
                    CircularProgressIndicator),
            findsOneWidget);
      });
    });
    testWidgets('renders error text if in error state',
        (WidgetTester tester) async {
      when(blocMock.currentState).thenAnswer((_) => MatchingError());
      await tester.pumpWidget(mqResultPage);
      expect(find.byType(ListView), findsNothing);
      expect(find.text('Noget gik galt!'), findsOneWidget);
      expect(find.text('Fejl ved identificering'), findsOneWidget);
    });
  });
}
