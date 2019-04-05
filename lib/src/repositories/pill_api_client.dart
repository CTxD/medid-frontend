import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';

class PillApiClient {
  final http.Client httpClient;

  PillApiClient({this.httpClient}) : assert(httpClient != null);

  static const jsonHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };
  static const baseUrl = 'https//www.whereisit.com';

  Future<List<MatchResult>> matchImage(String img) async {
    final response =
        await this.httpClient.get(baseUrl + img, headers: jsonHeaders);
    Iterable<Map<String, dynamic>> l = json.decode(response.body);

    List<MatchResult> results =
        l.map((Map model) => MatchResult.fromJson(model)).toList();
    return results;
  }

  Future<ExtendedPill> getExtendedPill(String tradename) async {
    final response = await this.httpClient.get(
          baseUrl + tradename,
          headers: jsonHeaders,
        );
    Map userMap = jsonDecode(response.body);
    return ExtendedPill.fromJson(userMap);
  }

  Future<List<SlimPill>> getSlims() async {
    final response = await this.httpClient.get(
          baseUrl,
          headers: jsonHeaders,
        );

    Iterable<Map<String, dynamic>> l = json.decode(response.body);

    List<SlimPill> results =
        l.map((Map model) => MatchResult.fromJson(model)).toList();
    return results;
  }
}
