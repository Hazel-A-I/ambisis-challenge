import 'package:ambisis_challenge/interfaces/license_repo.dart';
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLicenseRepository implements LicenseRepository {
  final FirebaseFirestore _firestore;

  FirebaseLicenseRepository(this._firestore);

  /// Mais especificamente, o companyId é o nome do documento dentro da coleção (da interface do FireStore)
  @override
  Future<List<LicenseModel>> readLicenses(String companyId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('companies')
          .doc(companyId)
          .collection('licenses')
          .get();

      /// Vai vir chave valor, então é mt melhor pra prever a tipagem se tiver type castado, e não genérico como Object?.
      return snapshot.docs.map((doc) {
        final String id = doc.id;
        return LicenseModel.fromJson(doc.data() as Map<String, dynamic>, id);
      }).toList();
    } on FirebaseException catch (e) {
      throw ("Error reading license: ${e.message}");
    } catch (e) {
      throw ("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<void> createLicense(LicenseModel license) async {
    try {
      await _firestore
          .collection('companies')
          .doc(license.companyId)
          .collection('licenses')
          .add(license.toJson());
    } on FirebaseException catch (e) {
      throw ("Error creating license: ${e.message}");
    } catch (e) {
      throw ("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<void> updateLicense(LicenseModel license) async {
    try {
      (license.id != null)
          ? await _firestore
              .collection('companies')
              .doc(license.companyId)
              .collection('licenses')
              .doc(license.id)
              .update(license.toJson())
          : throw Exception(
              "O ID da licença não pode estar nulo para a operação de UPDATE!");
    } on FirebaseException catch (e) {
      throw ("Error updating license: ${e.message}");
    } catch (e) {
      throw ("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteLicense(LicenseModel license) async {
    try {
      (license.id != null)
          ? await _firestore
              .collection('companies')
              .doc(license.companyId)
              .collection('licenses')
              .doc(license.id)
              .delete()
          : throw Exception(
              "O ID da licença não pode estar nulo para a operação de DELETE!");
    } on FirebaseException catch (e) {
      throw ("Error deleting license: ${e.message}");
    } catch (e) {
      throw ("Unexpected error: ${e.toString()}");
    }
  }
}
