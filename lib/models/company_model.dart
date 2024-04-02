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
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:ambisis_challenge/models/address.dart';
import 'package:ambisis_challenge/services/firebase/firebase_license_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/// queria fazer um padrão pra licensable mas desisti depois T-T
class CompanyModel implements Licensable {
  CompanyModel({
    required this.id,
    required this.legalName,
    required this.cnpj,
    required this.address,
  })  : _licenses = [],
        _addedAt = DateTime.now();

  final String id;
  final String legalName;
  final String cnpj;
  final Address address;
  final List<LicenseModel> _licenses;
  final DateTime _addedAt;

  FirebaseLicenseRepository? _licenseRepository;

  Future<void> initializeLicenseRepository(FirebaseFirestore firestore) async {
    _licenseRepository = FirebaseLicenseRepository(firestore);
  }

  String get addedAt {
    return DateFormat('dd/MM/yyyy').format(_addedAt);
  }

  /// Estou delegando os métodos como getLicenses para o LicenseRepository para não fazer overload na classe.
  @override
  Future<List<LicenseModel>> getLicenses() async {
    if (_licenseRepository == null) {
      throw Exception("License repository not initialized!");
    }
    return await _licenseRepository!.readLicenses(legalName);
  }

  @override
  void addLicense(LicenseModel license) async {
    if (_licenseRepository == null) {
      throw Exception("License repository not initialized!");
    }
    _licenses.add(license);
    await _licenseRepository!.createLicense(license);
  }

  @override
  void removeLicense(LicenseModel license) async {
    if (_licenseRepository == null) {
      throw Exception("License repository not initialized!");
    }
    _licenses.remove(license);
    await _licenseRepository!.deleteLicense(license);
  }

  @override
  Future<void> updateLicense(LicenseModel license) async {
    if (_licenseRepository == null) {
      throw Exception("License repository not initialized!");
    }
    int index = _licenses.indexOf(license);
    if (index != -1) {
      _licenses[index] = license;
    }
    await _licenseRepository!.updateLicense(license);
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

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json['id'],
        legalName: json['legalName'],
        cnpj: json['cnpj'],
        address: Address.fromJson(json['address']),
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "legalName": legalName,
      "cnpj": cnpj,
      "address": address.toJson(),
    };
  }
}
