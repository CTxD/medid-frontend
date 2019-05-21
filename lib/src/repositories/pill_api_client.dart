import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';

class Not200Error extends Error {
  final int statusCode;

  Not200Error({this.statusCode});
}

class RequestFailedError extends Error {
  final int statusCode;

  RequestFailedError({this.statusCode});
}

class PillApiClient {
  final http.Client httpClient;

  PillApiClient({this.httpClient}) : assert(httpClient != null);

  static const jsonHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };
  static const baseUrl = 'http://3157f4a9.ngrok.io/api/v1/fx/';

  Future<List<MatchResult>> identifyPill(String img, String imprint, int width, int height) async {
    try {
      final input = TestPillRepresentation(imprintid: imprint, imgstring: img, width: width, height: height);
      print(img);
      final response = await this
          .httpClient
          .put(baseUrl + 'getmatches', headers: jsonHeaders, body: json.encode(input));
      if (response.statusCode != 200)
        throw Not200Error(statusCode: response.statusCode);
      Iterable l = json.decode(response.body);

      List<MatchResult> results =
          l.map((dynamic model) => MatchResult.fromJson(model)).toList();
      return results;
    } catch (e) {
      print(e);
      if (e is Not200Error)
        throw e;
      else
        throw RequestFailedError();
    }
  }

  Future<ExtendedPill> getExtendedPill(String tradename) async {
    try {
      final response = await this.httpClient.get(
            baseUrl + tradename,
            headers: jsonHeaders,
          );
      if (response.statusCode != 200)
        throw Not200Error(statusCode: response.statusCode);
      Map userMap = jsonDecode(response.body);
      return ExtendedPill.fromJson(userMap);
    } catch (e) {
      if (e is Not200Error)
        throw e;
      else
        throw RequestFailedError();
    }
  }

  Future<List<SlimPill>> getSlims() async {
    try {
      final response = await this.httpClient.get(
            baseUrl,
            headers: jsonHeaders,
          );

      if (response.statusCode != 200)
        throw Not200Error(statusCode: response.statusCode);
      final Iterable l = json.decode(response.body);
      List<SlimPill> ps =
          l.map((dynamic model) => SlimPill.fromJson(model)).toList();
      return ps;
    } catch (e) {
      if (e is Not200Error)
        throw e;
      else
        throw RequestFailedError();
    }
  }
}
