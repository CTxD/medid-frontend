import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';
import 'package:medid/src/repositories/pill_api_client.dart';
import 'package:meta/meta.dart';

class PillRepository {
  final PillApiClient pillApiClient;
  PillRepository({@required this.pillApiClient});

  Future<List<MatchResult>> identifyPill(File pill) async {
    final bytes = await pill.readAsBytes();
    final stringRep = base64UrlEncode(bytes);
    final matches = pillApiClient.matchImage(stringRep);
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
