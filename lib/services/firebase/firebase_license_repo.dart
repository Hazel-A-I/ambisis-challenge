import 'package:ambisis_challenge/interfaces/license_repo.dart';
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLicenseRepository implements LicenseRepository {
  final FirebaseFirestore _firestore;

  FirebaseLicenseRepository(this._firestore);

  @override
  Future<List<LicenseModel>> readLicenses(String companyId) async {
    final QuerySnapshot snapshot = await _firestore
        .collection('companies')
        .where("id", isEqualTo: companyId)
        .get();

    final companyDoc = snapshot.docs.first;
    final licenseSnapshot =
        await companyDoc.reference.collection('licenses').get();

    if (licenseSnapshot.docs.isEmpty) {
      return [];
    }
    final List<LicenseModel> licenses = licenseSnapshot.docs.map((doc) {
      return LicenseModel.fromJson(doc.data());
    }).toList();

    return licenses;
  }

  @override
  Future<void> createLicense(LicenseModel license) async {
    final QuerySnapshot snapshot = await _firestore
        .collection('companies')
        .where("id", isEqualTo: license.companyId)
        .get();

    snapshot.docs.first.reference.collection('licenses').add(license.toJson());
  }

  @override
  Future<void> updateLicense(LicenseModel license) async {
    final QuerySnapshot snapshot = await _firestore
        .collection('companies')
        .where("id", isEqualTo: license.companyId)
        .get();

    final QuerySnapshot licenseSnapshot = await snapshot.docs.first.reference
        .collection('licenses')
        .where('id', isEqualTo: license.id)
        .get();

    licenseSnapshot.docs.first.reference.update(license.toJson());
  }

  @override
  Future<void> deleteLicense(LicenseModel license) async {
    final QuerySnapshot snapshot = await _firestore
        .collection('companies')
        .where("id", isEqualTo: license.companyId)
        .get();

    final QuerySnapshot licenseSnapshot = await snapshot.docs.first.reference
        .collection('licenses')
        .where('id', isEqualTo: license.id)
        .get();

    licenseSnapshot.docs.first.reference.delete();
  }
}
