import 'package:ambisis_challenge/models/license_model.dart';

abstract class Licensable {
  List<LicenseModel> getLicenses();
  void addLicense(LicenseModel license);
  void removeLicense(LicenseModel license);
  void updateLicense(LicenseModel license);
  void sortLicenses();
  Iterable<LicenseModel> filterLicenses(String filter);
}
