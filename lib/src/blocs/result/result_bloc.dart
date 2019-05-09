import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';
import 'package:medid/src/repositories/pill_repository.dart';
import './bloc.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final PillRepository pillRepository;

  ResultBloc({@required this.pillRepository, @required this.createFile});
  @override
  ResultState get initialState => LoadingMatches();

  final createFile;

  @override
  Stream<ResultState> mapEventToState(
    ResultEvent event,
  ) async* {
    if (event is ChosenImprint) {

      yield SelectedImprint(
          imageFilePath: this.currentState.imageFilePath,
          imprints: (this.currentState as UserSelectImprint).imprints,
          chosenImprint: event.imprint);
    }

    if (event is ResultPageLoaded) {
      try {
        final s = await event.imprintsJson;
        final l = await json.decode(s);
        final imps = Map<String, dynamic>.from(l);
        final impImages = imps.map((k, v) {
          final bytes = Base64Decoder().convert(v);
          return MapEntry(k, bytes);
        });
        yield UserSelectImprint(
            imageFilePath: event.imageFilePath,
            imprints: impImages);
      } catch (e) {
        print(e);
      }
    }
    if (event is MatchClicked) {
      try {
        final ExtendedPill info =
            await pillRepository.getExtendedPill(event.clickedMr.tradeName);
        yield ShowPillInfo(pillInfo: info);
      } catch (_) {
        yield ShowPillInfoError();
      }
    }

    if (event is UserInitRecog) {
      if (!(this.currentState is LoadingMatches))
        yield LoadingMatches(imageFilePath: event.imageFilePath);
      try {
        final List<MatchResult> rs =
            await pillRepository.identifyPill(createFile(event.imageFilePath), event.imprint);
        yield FoundMatches(results: rs, imageFilePath: event.imageFilePath, imprint:event.imprint);
      } catch (e) {
        yield MatchingError(error: e, imageFilePath: event.imageFilePath);
      }
    }
  }
}
