import 'package:ambisis_challenge/models/license_model.dart';

/// Repositório das licenças, CRUD básico.

abstract class LicenseRepository {
  Future<List<LicenseModel>> readLicenses(String companyId);
  Future<void> createLicense(LicenseModel license);
  Future<void> updateLicense(LicenseModel license);
  Future<void> deleteLicense(LicenseModel license);
}
