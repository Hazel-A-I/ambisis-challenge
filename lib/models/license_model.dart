/*
Cadastro de licenças ambientais:
Campos necessários:
Empresa (relacionando a um item da tabela de empresa, esse campo será um “select”);
Número (texto livre, pode conter letras no número da licença);
Órgão ambiental (texto);
Emissão (data);
Validade (data);

*/
import 'package:intl/intl.dart';

class LicenseModel {
  LicenseModel({
    required this.id,
    required this.companyId,
    required this.licenseNumber,
    required this.environmentalAgency,
    required this.issueDate,
    required this.expirationDate,
  });

  final String id;
  final String companyId;
  final String licenseNumber;
  final String environmentalAgency;
  final DateTime issueDate;
  final DateTime expirationDate;

  String get formattedIssueDate => DateFormat('yyyy-MM-dd').format(issueDate);

  String get formattedExpirationDate =>
      DateFormat('yyyy-MM-dd').format(expirationDate);

  factory LicenseModel.fromJson(Map<String, dynamic> json) => LicenseModel(
        id: json['id'],
        companyId: json['companyId'],
        licenseNumber: json['licenseNumber'],
        environmentalAgency: json['environmentalAgency'],
        issueDate: DateTime.parse(json['issueDate']),
        expirationDate: DateTime.parse(json['expirationDate']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyId': companyId,
        'licenseNumber': licenseNumber,
        'environmentalAgency': environmentalAgency,
        'issueDate': issueDate.toString(),
        'expirationDate': expirationDate.toString(),
      };
}
