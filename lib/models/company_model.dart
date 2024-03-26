/*
Cadastro de empresa:
Campos necessários:
Razão social (nome profissional da empresa) (texto);
CNPJ (cadastro nacional de pessoa juridica) (texto);
Endereço {
  CEP (texto);
  Cidade (texto);
  Estado (texto);
  Bairro (texto);
  Complemento (texto);
}
Abaixo dos campos, colocar uma lista de todas as licenças ambientais dessa empresa. E um botão para adicionar uma nova licença nessa empresa (esse botão direciona para o cadastro de licença).

*/

import 'package:ambisis_challenge/interfaces/licensable.dart';
import 'package:ambisis_challenge/interfaces/license_repo.dart';
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:ambisis_challenge/models/address.dart';
import 'package:intl/intl.dart';

class CompanyModel implements Licensable {
  CompanyModel(
      {required this.legalName,
      required this.cnpj,
      required this.address,
      required this.licenseRepository})
      : _licenses = [],
        _addedAt = DateTime.now();

  final String legalName;
  final String cnpj;
  final Address address;
  final LicenseRepository licenseRepository;
  final List<LicenseModel> _licenses;
  final DateTime _addedAt;

  String get addedAt {
    return DateFormat('dd/MM/yyyy').format(_addedAt);
  }

  /// Estou delegando os métodos como getLicenses para o LicenseRepository para não fazer overload na classe.
  @override
  Future<List<LicenseModel>> getLicenses() async {
    return await licenseRepository.readLicenses(legalName);
  }

  @override
  void addLicense(LicenseModel license) async {
    _licenses.add(license);
    await licenseRepository.createLicense(license);
  }

  @override
  void removeLicense(LicenseModel license) async {
    _licenses.remove(license);
    await licenseRepository.deleteLicense(license);
  }

  @override
  Future<void> updateLicense(LicenseModel license) async {
    int index = _licenses.indexOf(license);
    if (index != -1) {
      _licenses[index] = license;
    }
    await licenseRepository.updateLicense(license);
  }

  /// são duas funções que achei que em algum momento eu poderia precisar.
  @override
  void sortLicenses() {
    _licenses.sort((a, b) => a.expirationDate.compareTo(b.expirationDate));
  }

  @override
  List<LicenseModel> filterLicenses(String filter) {
    return _licenses
        .where((license) =>
            license.licenseNumber.contains(filter) ||
            license.environmentalAgency.contains(filter))
        .toList();
  }
}
