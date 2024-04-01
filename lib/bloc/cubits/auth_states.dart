import 'package:ambisis_challenge/models/user_model.dart';

abstract class UserState {}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class LoggedInState extends UserState {
  final UserModel user;
  LoggedInState(this.user);
}

class LoggedOutState extends UserState {}

class ErrorUserState extends UserState {
  final String errorMessage;
  ErrorUserState(this.errorMessage);
}
