/*
Cadastro de empresa:
Campos necessários:
Razão social (texto);
CNPJ (texto);
CEP (texto);
Cidade (texto);
Estado (texto);
Bairro (texto);
Complemento (texto);
Abaixo dos campos, colocar uma lista de todas as licenças ambientais dessa empresa. E um botão para adicionar uma nova licença nessa empresa (esse botão direciona para o cadastro de licença).

*/

import 'package:ambisis_challenge/interfaces/licensable.dart';
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:ambisis_challenge/models/address.dart';

class CompanyModel implements Licensable {
  CompanyModel(
      {required this.legalName,
      required this.cnpj,
      required this.address,
      required this.licenses});

  final String legalName;
  final String cnpj;
  final Address address;
  final List<LicenseModel> licenses;

  @override
  List<LicenseModel> getLicenses() {
    return licenses;
  }

  @override
  void addLicense(LicenseModel license) {
    licenses.add(license);
  }

  @override
  void removeLicense(LicenseModel license) {
    licenses.remove(license);
  }

  @override
  void updateLicense(LicenseModel license) {
    int index = licenses.indexOf(license);
    licenses[index] = license;
  }

  @override
  void sortLicenses() {
    licenses.sort((a, b) => a.expirationDate.compareTo(b.expirationDate));
  }

  @override
  Iterable<LicenseModel> filterLicenses(String filter) {
    return licenses.where((license) =>
        license.number.contains(filter) ||
        license.environmentalAgency.contains(filter));
  }
}
