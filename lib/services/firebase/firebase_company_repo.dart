import 'package:ambisis_challenge/models/company_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyRepository {
  final FirebaseFirestore _firestore;

  CompanyRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<List<CompanyModel>> readCompanies() async {
    final snapshot = await _firestore.collection('companies').get();
    return snapshot.docs.map((doc) {
      final String id = doc.id;
      return CompanyModel.fromJson(doc.data(), id);
    }).toList();
  }

  Future<void> createCompany(CompanyModel company) async {
    await _firestore.collection('companies').add(company.toJson());
  }

  Future<void> updateCompany(CompanyModel company) async {
    await _firestore
        .collection('companies')
        .doc(company.id)
        .update(company.toJson());
  }

  Future<void> deleteCompany(CompanyModel company) async {
    await _firestore.collection('companies').doc(company.id).delete();
  }
}
