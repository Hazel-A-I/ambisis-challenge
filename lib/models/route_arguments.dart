import 'package:ambisis_challenge/models/company_model.dart';
import 'package:ambisis_challenge/models/license_model.dart';

class RouteArguments {
  final CompanyModel? currentCompany;
  final LicenseModel? currentLicense;
  final bool isEditing;

  const RouteArguments(
      {this.currentCompany, this.currentLicense, required this.isEditing});
}

class LicenseArguments {
  final CompanyModel currentCompany;
  final LicenseModel? currentLicense;
  final bool isEditing;

  const LicenseArguments({
    required this.isEditing,
    this.currentLicense,
    required this.currentCompany,
  });
}
