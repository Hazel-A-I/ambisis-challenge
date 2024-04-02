import 'package:ambisis_challenge/models/company_model.dart';

abstract class CompanyState {}

class InitialCompanyState extends CompanyState {}

class LoadingCompanyState extends CompanyState {}

class CompanyLoadedState extends CompanyState {
  final List<CompanyModel> companies;
  CompanyLoadedState(this.companies);
}

class ErrorCompanyState extends CompanyState {
  final String errorMessage;
  ErrorCompanyState(this.errorMessage);
}
