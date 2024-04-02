import 'package:ambisis_challenge/models/company_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyRepository {
  final FirebaseFirestore _firestore;

  CompanyRepository(FirebaseFirestore firestore) : _firestore = firestore;

  Future<CompanyModel> getCompanyById(String id) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('companies')
        .where("id", isEqualTo: id)
        .get();
    return querySnapshot.docs.map((doc) {
      return CompanyModel.fromJson(
        doc.data() as Map<String, dynamic>,
      );
    }).first;
  }

  Future<List<CompanyModel>> readCompanies() async {
    final snapshot = await _firestore.collection('companies').get();
    return snapshot.docs.map((doc) {
      return CompanyModel.fromJson(
        doc.data(),
      );
    }).toList();
  }

  Future<void> createCompany(CompanyModel company) async {
    await _firestore.collection('companies').add(company.toJson());
  }

  Future<void> updateCompany(CompanyModel company) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('companies')
        .where('id', isEqualTo: company.id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final documentRef = querySnapshot.docs.first.reference;
      await documentRef.update(company.toJson());
    } else {
      print("No company found to edit with ID: ${company.id}");
    }
  }

  Future<void> deleteCompany(CompanyModel company) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('companies')
        .where('id', isEqualTo: company.id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final documentRef = querySnapshot.docs.first.reference;
      await documentRef.delete();
    } else {
      print("No company found to delete with ID: ${company.id}");
    }
  }
}
