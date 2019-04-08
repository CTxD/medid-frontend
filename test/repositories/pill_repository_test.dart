import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/models/pill_extended.dart';
import 'package:medid/src/repositories/pill_api_client.dart';
import 'package:medid/src/repositories/pill_repository.dart';
import 'package:mockito/mockito.dart';

class MockPillApiClient extends Mock implements PillApiClient {}

main() {
  MockPillApiClient apiClient;
  group('Pill Repository', () {
    setUp(() {
      apiClient = MockPillApiClient();
    });
    test('getSlims returns pillApiClient value', () async {
      final pillRepo = PillRepository(pillApiClient: apiClient);
      final List<SlimPill> slims = [
        SlimPill(
            tradeName: 'Panodil', strength: '20mg', activeSubstance: 'Coffein'),
        SlimPill(
            tradeName: 'Viagra', strength: '10mg', activeSubstance: 'Water'),
        SlimPill(
            tradeName: 'Amphetamine', strength: '1kg', activeSubstance: 'N/A'),
      ];
      when(apiClient.getSlims()).thenAnswer((_) => Future.value(slims));
      final actualSlims = await pillRepo.getSlimPills();
      expect(actualSlims, slims);
    });
    test('getExtended returns pillApiClient value', () async {
      final pillRepo = PillRepository(pillApiClient: apiClient);
      final ExtendedPill exp = ExtendedPill(
          tradeName: 'Panodil', strength: '20mg', activeSubstance: 'Coffein');
      when(apiClient.getExtendedPill('Panodil'))
          .thenAnswer((_) => Future.value(exp));
      final actualExp = await pillRepo.getExtendedPill('Panodil');
      expect(actualExp, exp);
    });

    test('identifyPill returns pillApiClient value', () async {
      final pillRepo = PillRepository(pillApiClient: apiClient);
      final mockedFile = MockFile();
      final fileAsBytes = [1,2,3];
      final List<MatchResult> mrs = [
        MatchResult(
            tradeName: 'Panodil', strength: '20mg', activeSubstance: 'Coffein'),
        MatchResult(
            tradeName: 'Viagra', strength: '10mg', activeSubstance: 'Water'),
        MatchResult(
            tradeName: 'Amphetamine', strength: '1kg', activeSubstance: 'N/A'),
      ];

      
      when(mockedFile.readAsBytes()).thenAnswer((_) => Future.value(fileAsBytes));
      when(apiClient.identifyPill(base64UrlEncode(fileAsBytes))).thenAnswer((_) => Future.value(mrs));
      final actualMrs = await pillRepo.identifyPill(mockedFile);
      for (var i = 0; i < 3; i++) {
        expect(actualMrs[i].tradeName, mrs[i].tradeName);
      }
    });


  });
}
class MockFile extends Mock implements File{}
