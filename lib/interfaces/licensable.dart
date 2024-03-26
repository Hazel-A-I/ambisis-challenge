import 'package:ambisis_challenge/models/license_model.dart';

/// Abstraindo as funcionalidades comuns, dá pra criar outros modelos que seguem esse estilo, além das empresas como é no CompanyModel.
abstract class Licensable {
  Future<List<LicenseModel>> getLicenses();
  void addLicense(LicenseModel license);
  void updateLicense(LicenseModel license);
  void removeLicense(LicenseModel license);
  void sortLicenses();
  Iterable<LicenseModel> filterLicenses(String filter);
}
