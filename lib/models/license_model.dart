/*
Cadastro de licenças ambientais:
Campos necessários:
Empresa (relacionando a um item da tabela de empresa, esse campo será um “select”);
Número (texto livre, pode conter letras no número da licença);
Órgão ambiental (texto);
Emissão (data);
Validade (data);

*/

import 'package:ambisis_challenge/models/company_model.dart';

class LicenseModel {
  LicenseModel({
    required this.id,
    required this.companyId,
    required this.number,
    required this.environmentalAgency,
    required this.issueDate,
    required this.expirationDate,
  });

  int id;
  int companyId;
  String number;
  String environmentalAgency;
  DateTime issueDate;
  DateTime expirationDate;

  // Métodos adicionais p/ firestore:
  // - Inserir nova licença
  // - Atualizar licença
  // - Buscar licença por ID
  // - Listar licenças
  // - Validar campos
}
