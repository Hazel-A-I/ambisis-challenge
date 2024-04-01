import 'package:ambisis_challenge/models/company_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyRepository {
  final FirebaseFirestore _firestore;

  CompanyRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<List<CompanyModel>> readCompanies() async {
    try {
      final snapshot = await _firestore.collection('companies').get();
      return snapshot.docs.map((doc) {
        final String id = doc.id;
        return CompanyModel.fromJson(doc.data(), id);
      }).toList();
    } on FirebaseException catch (e) {
      throw ("Error reading companies: ${e.message}");
    } catch (e) {
      throw ("Unexpected error: ${e.toString()}");
    }
  }

  Future<void> createCompany(CompanyModel company) async {
    try {
      await _firestore.collection('companies').add(company.toJson());
    } on FirebaseException catch (e) {
      throw ("Error creating companies: ${e.message}");
    } catch (e) {
      throw ("Unexpected error: ${e.toString()}");
    }
  }

  Future<void> updateCompany(CompanyModel company) async {
    try {
      await _firestore
          .collection('companies')
          .doc(company.id)
          .update(company.toJson());
    } on FirebaseException catch (e) {
      throw ("Error updating companies: ${e.message}");
    } catch (e) {
      throw ("Unexpected error: ${e.toString()}");
    }
  }

  Future<void> deleteCompany(CompanyModel company) async {
    try {
      await _firestore.collection('companies').doc(company.id).delete();
    } on FirebaseException catch (e) {
      throw ("Error deleting companies: ${e.message}");
    } catch (e) {
      throw ("Unexpected error: ${e.toString()}");
    }
  }
}
