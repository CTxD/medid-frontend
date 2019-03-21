import 'package:medid/src/models/match_result.dart';

class PillExtended extends MatchResult {
  final List<String> breastFeeding = [];
  final List<String> otherFieldsOfApplication = [];
  final List<String> fieldsOfApplication = [];

  final List<String> commonSideEffects = [];
  final List<String> uncommonSideEffects = [];
  final List<String> unknownSideEffects = [];

  final List<String> bloodDonor = [];
  final List<String> dispensingForms = [];
  final List<String> doping = [];
  final List<String> dosageProposals = [];
  final List<String> featuresHandlingDurability = [];
  final List<String> pharmacodynamics = [];
  final List<String> pharmacokinetics = [];
  final List<String> company = [];
  final List<String> poisoning = [];
  final List<String> precautions = [];
  final List<PhotoIdentification> photoIdentifications = [];
  final List<String> pregnancy = [];
  final List<String> exipients = [];
  final List<String> substances = [];
  final List<String> instructions = [];
  final List<String> interactions = [];
  final List<String> contraIndications = [];
  final List<String> hepaticImpairment = [];
  final List<String> renalImpairment = [];
  final List<MarketRepresentation> marketRepresentations = [];
  final List<String> schengenCertificates = [];
  final List<String> substitutions = [];
  final List<String> subsidies = [];
  final String traffic = '';
  final List<CommonError> crucialErrors = [];
}

class CommonError {
  final String description = '';
  final String consequence = '';
}

class MarketRepresentation {
  final String subsidy = '';
  final String delivery = '';
  final String dispensingForm = '';
  final String vNumber = '';
  final String packaging = '';
  final String priceInDkk = '';
  final String dddPrice = '';
}

class PhotoIdentification {
  final String type = '';
  final String imprint = '';
  final String score = '';
  final String colour = '';
  final String sizeDimensions = '';
  final String imageUrl = '';
}
