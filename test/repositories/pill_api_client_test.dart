import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';
import 'package:medid/src/repositories/pill_api_client.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

main() {
  MockHttpClient httpClient;
  setUp(() {
    httpClient = MockHttpClient();
  });
  group('PillApiClient', () {
    test('should throw when initialized with null argument', () {
      expect(() => PillApiClient(httpClient: null),
          throwsA(isInstanceOf<AssertionError>()));
    });

    test('getExtendedPill throws Not200Error when statuscode is not 200',
        () async {
      final apiClient = PillApiClient(httpClient: httpClient);
      when(httpClient.get(PillApiClient.baseUrl + 'Panodil',
              headers: PillApiClient.jsonHeaders))
          .thenAnswer((_) => Future.value(http.Response('', 404)));

      expect(apiClient.getExtendedPill('Panodil'),
          throwsA(isInstanceOf<Not200Error>()));
    });

    test('getExtendedPill throws RequestFailedError when the request throws', () async {
      final apiClient = PillApiClient(httpClient: httpClient);
      when(httpClient.get(PillApiClient.baseUrl + 'Panodil',
              headers: PillApiClient.jsonHeaders))
          .thenThrow(Error());
      expect(apiClient.getExtendedPill('Panodil'),
          throwsA(isInstanceOf<RequestFailedError>()));
    });
    test('getExtendedPill returns correct extendedpill given eligible response',
        () async {
      final apiClient = PillApiClient(httpClient: httpClient);
      final tradeName = 'Panodil';
      final ExtendedPill exp = ExtendedPill(
          tradeName: tradeName, strength: '20mg', activeSubstance: 'Coffein');

      final jsonExp = json.encode(exp);
      when(httpClient.get(PillApiClient.baseUrl + tradeName,
              headers: PillApiClient.jsonHeaders))
          .thenAnswer((_) => Future.value(http.Response(jsonExp, 200)));

      final res = await apiClient.getExtendedPill(tradeName);
      expect(res.tradeName, exp.tradeName);
    });

    test('identifyPill throws Not200Error when statuscode is not 200', () async {
      final byteRep = 'AEIDPAOD';
      final apiClient = PillApiClient(httpClient: httpClient);
      when(httpClient.get(PillApiClient.baseUrl + byteRep,
              headers: PillApiClient.jsonHeaders))
          .thenAnswer((_) => Future.value(http.Response('', 404)));

      expect(
          apiClient.identifyPill(byteRep), throwsA(isInstanceOf<Not200Error>()));
    });

    test('identifyPill throws RequestFailedError when the request throws', () async {
      final byteRep = 'AEIDPAOD';
      final apiClient = PillApiClient(httpClient: httpClient);
      when(httpClient.get(PillApiClient.baseUrl + byteRep,
              headers: PillApiClient.jsonHeaders)).thenThrow(Error());

      expect(
          apiClient.identifyPill(byteRep), throwsA(isInstanceOf<RequestFailedError>()));
    });
    test('identifyPill returns correct match results given eligible response',
        () async {
      final byteRep = 'AEIDPAOD';
      final List<MatchResult> results = [
        MatchResult(
            tradeName: 'Panodil', strength: '20mg', activeSubstance: 'Coffein'),
        MatchResult(
            tradeName: 'Viagra', strength: '10mg', activeSubstance: 'Water'),
        MatchResult(
            tradeName: 'Amphetamine', strength: '1kg', activeSubstance: 'N/A'),
      ];
      final apiClient = PillApiClient(httpClient: httpClient);
      when(httpClient.get(PillApiClient.baseUrl + byteRep,
              headers: PillApiClient.jsonHeaders))
          .thenAnswer(
              (_) => Future.value(http.Response(json.encode(results), 200)));
      final mrs = await apiClient.identifyPill(byteRep);
      for (var i = 0; i < 3; i++) {
        expect(mrs[i].tradeName, results[i].tradeName);
      }
    });

    test('getSlims throws Not200Error when statuscode is not 200', () async {
      final apiClient = PillApiClient(httpClient: httpClient);
      when(httpClient.get(PillApiClient.baseUrl,
              headers: PillApiClient.jsonHeaders))
          .thenAnswer((_) => Future.value(http.Response('', 404)));

      expect(apiClient.getSlims(), throwsA(isInstanceOf<Not200Error>()));
    });

    test('getSlims throws Error when the request throws', () async {
      final apiClient = PillApiClient(httpClient: httpClient);
      when(httpClient.get(PillApiClient.baseUrl,
              headers: PillApiClient.jsonHeaders))
          .thenThrow(Error());

      expect(apiClient.getSlims(), throwsA(isInstanceOf<RequestFailedError>()));
    });

    test('getSlims return objects when given eligible response', () async {
      final List<SlimPill> results = [
        SlimPill(
            tradeName: 'Panodil', strength: '20mg', activeSubstance: 'Coffein'),
        SlimPill(
            tradeName: 'Viagra', strength: '10mg', activeSubstance: 'Water'),
        SlimPill(
            tradeName: 'Amphetamine', strength: '1kg', activeSubstance: 'N/A'),
      ];

      final jsonRes = json.encode(results);
      final apiClient = PillApiClient(httpClient: httpClient);
      when(httpClient.get(PillApiClient.baseUrl,
              headers: PillApiClient.jsonHeaders))
          .thenAnswer((_) => Future.value(http.Response(jsonRes, 200)));

      final slims = await apiClient.getSlims();
      for (var i = 0; i < 3; i++) {
        expect(slims[i].activeSubstance, results[i].activeSubstance);
      }
    });
  });
}
