import 'package:ambisis_challenge/bloc/cubits/license_states.dart';
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:ambisis_challenge/services/firebase/firebase_license_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LicenseCubit extends Cubit<LicenseState> {
  final FirebaseFirestore firestoreInstance;
  final FirebaseLicenseRepository licenseRepo;
  LicenseCubit({required this.firestoreInstance})
      : licenseRepo = FirebaseLicenseRepository(firestoreInstance),
        super(InitialLicenseState());

  Future<void> fetchCompanyLicenses(companyId) async {
    emit(LoadingLicenseState());
    try {
      final List<LicenseModel> licenses =
          await licenseRepo.readLicenses(companyId);
      emit(LicenseLoadedState(licenses));
    } on FirebaseException catch (error) {
      emit(ErrorLicenseState(
          "Falha ao tentar buscar por licenças: ${error.toString()}"));
    } catch (error) {
      emit(ErrorLicenseState("Erro inesperado: ${error.toString()}"));
    }
  }

  Future<void> addLicense(LicenseModel license) async {
    emit(LoadingLicenseState());
    try {
      await licenseRepo.createLicense(license);
      final List<LicenseModel> licenses =
          await licenseRepo.readLicenses(license.companyId);
      emit(LicenseLoadedState(licenses));
    } on FirebaseException catch (error) {
      emit(ErrorLicenseState(
          "Falha ao tentar criar licença: ${error.toString()}"));
    } catch (error) {
      emit(ErrorLicenseState("Erro inesperado: ${error.toString()}"));
    }
  }

  Future<void> editLicense(LicenseModel license) async {
    emit(LoadingLicenseState());
    try {
      await licenseRepo.updateLicense(license);
      final List<LicenseModel> licenses =
          await licenseRepo.readLicenses(license.companyId);
      emit(LicenseLoadedState(licenses));
    } on FirebaseException catch (error) {
      emit(ErrorLicenseState(
          "Falha ao tentar editar licença: ${error.toString()}"));
    } catch (error) {
      emit(ErrorLicenseState("Erro inesperado: ${error.toString()}"));
    }
  }

  Future<void> removeLicense(LicenseModel license) async {
    emit(LoadingLicenseState());
    try {
      await licenseRepo.deleteLicense(license);
      final List<LicenseModel> licenses =
          await licenseRepo.readLicenses(license.companyId);
      emit(LicenseLoadedState(licenses));
    } on FirebaseException catch (error) {
      emit(ErrorLicenseState(
          "Falha ao tentar apagar licença: ${error.toString()}"));
    } catch (error) {
      emit(ErrorLicenseState("Erro inesperado: ${error.toString()}"));
    }
  }
}
