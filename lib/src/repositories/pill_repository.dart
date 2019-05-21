import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';
import 'package:medid/src/repositories/pill_api_client.dart';
import 'package:meta/meta.dart';
import 'package:image/image.dart' as bImg;

class PillRepository {
  final PillApiClient pillApiClient;
  PillRepository({@required this.pillApiClient});

  Future<ui.Image> _getImage(File pill) {
    Completer<ui.Image> completer = new Completer<ui.Image>();
    Image.file(pill)
        .image
        .resolve(ImageConfiguration())
        .addListener((info, b) => completer.complete(info.image));
    return completer.future;
  }

  // final offsetY = size.height * .1;
  // final rectSize = size.width * .55;
  // final startX = size.width * .5 - rectSize / 2;
  // final startY = (size.height * .5 - rectSize / 2) - offsetY;
  // final endX = startX + rectSize;
  // final endY = startY + rectSize;
  Future<List<MatchResult>> identifyPill(File pill, String imprint) async {
    final img = await _getImage(pill);
    final bytes = await pill.readAsBytes();

    final stringRep = base64Encode(bytes);
    final matches =
        pillApiClient.identifyPill(stringRep, imprint, img.width, img.height);
    return matches;
  }

  Future<ExtendedPill> getExtendedPill(String tradeName) {
    final exPill = pillApiClient.getExtendedPill(tradeName);
    return exPill;
  }

  Future<List<SlimPill>> getSlimPills() {
    return pillApiClient.getSlims();
  }
}
