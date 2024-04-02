import 'package:ambisis_challenge/bloc/cubits/company_states.dart';
import 'package:ambisis_challenge/models/company_model.dart';
import 'package:ambisis_challenge/services/firebase/firebase_company_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyCubit extends Cubit<CompanyState> {
  final FirebaseFirestore firestoreInstance;
  final CompanyRepository companyRepo;
  CompanyCubit({required this.firestoreInstance})
      : companyRepo = CompanyRepository(firestoreInstance),
        super(InitialCompanyState());

  Future<void> fetchCompanies() async {
    emit(LoadingCompanyState());
    try {
      final List<CompanyModel> companies = await companyRepo.readCompanies();
      emit(CompanyLoadedState(companies));
    } on FirebaseException catch (error) {
      emit(ErrorCompanyState(
          "Falha ao tentar buscar por empresas: ${error.toString()}"));
    } catch (error) {
      emit(ErrorCompanyState("Erro inesperado: ${error.toString()}"));
    }
  }

  Future<void> createCompany(CompanyModel company) async {
    emit(LoadingCompanyState());
    try {
      companyRepo.createCompany(company);
      final List<CompanyModel> companies = await companyRepo.readCompanies();
      emit(CompanyLoadedState(companies));
    } on FirebaseException catch (error) {
      emit(ErrorCompanyState(
          "Falha ao tentar criar uma empresa: ${error.toString()}"));
    } catch (error) {
      emit(ErrorCompanyState("Erro inesperado: ${error.toString()}"));
    }
  }

  Future<void> updateCompany(CompanyModel company) async {
    emit(LoadingCompanyState());
    try {
      await companyRepo.updateCompany(company);
      final List<CompanyModel> companies = await companyRepo.readCompanies();
      emit(CompanyLoadedState(companies));
    } on FirebaseException catch (error) {
      emit(ErrorCompanyState(
          "Falha ao tentar editar uma empresa: ${error.toString()}"));
    } catch (error) {
      emit(ErrorCompanyState("Erro inesperado: ${error.toString()}"));
    }
  }

  Future<void> deleteCompany(CompanyModel company) async {
    emit(LoadingCompanyState());
    try {
      await companyRepo.deleteCompany(company);
      final List<CompanyModel> companies = await companyRepo.readCompanies();
      emit(CompanyLoadedState(companies));
    } on FirebaseException catch (error) {
      emit(ErrorCompanyState(
          "Falha ao tentar deletar a empresa: ${error.toString()}"));
    } catch (error) {
      emit(ErrorCompanyState("Erro inesperado: ${error.toString()}"));
    }
  }

  Future<CompanyModel> getCompanyById(String companyId) async {
    try {
      final company = await companyRepo.getCompanyById(companyId);
      return company;
    } catch (error) {
      print('Error fetching company: $error');
      throw 'Erro: ${error.toString()}';
    }
  }
}
