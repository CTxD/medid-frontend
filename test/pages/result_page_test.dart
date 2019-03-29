import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/bloc/bloc.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/ui/result_page.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:medid/src/ui/widgets/pill_list.dart';
import 'package:mockito/mockito.dart';

class ResultBlocMock extends Mock implements ResultBloc {}

class FeatureExtractorMock extends Mock implements FeatureExtractor {}

main() {
  group('Result screen', () {
    ResultBloc blocMock;
    setUp(() {
      blocMock = ResultBlocMock();
    });
    testWidgets('has the proper title', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        Widget mqResultPage = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new ResultPage(resultBloc: blocMock)));
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
        Widget mqResultPage = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new ResultPage(resultBloc: blocMock)));

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
        Widget mqResultPage = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new ResultPage(resultBloc: blocMock)));

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
  });
}
