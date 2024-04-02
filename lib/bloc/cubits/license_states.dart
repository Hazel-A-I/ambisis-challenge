import 'package:ambisis_challenge/models/license_model.dart';

abstract class LicenseState {}

class InitialLicenseState extends LicenseState {}

class LoadingLicenseState extends LicenseState {}

class LicenseLoadedState extends LicenseState {
  final List<LicenseModel> licenses;
  LicenseLoadedState(this.licenses);
}

class ErrorLicenseState extends LicenseState {
  final String errorMessage;
  ErrorLicenseState(this.errorMessage);
}
