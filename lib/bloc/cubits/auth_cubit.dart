import 'dart:async';

import 'package:ambisis_challenge/bloc/cubits/auth_states.dart';
import 'package:ambisis_challenge/models/user_model.dart';
import 'package:ambisis_challenge/services/auth/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCubit extends Cubit<UserState> {
  UserModel? _currentUser;

  bool isLoggedIn() => _currentUser != null;
  UserModel? get user => _currentUser;

  final StreamController<UserModel?> _userStreamController =
      StreamController<UserModel?>();

  void setUser(UserModel userModel) {
    _currentUser = userModel;
    _userStreamController.sink.add(_currentUser!);
  }

  Stream<UserModel?> get userStream => _userStreamController.stream;

  UserCubit() : super(InitialUserState()) {
    _userStreamController.sink.add(_currentUser);
  }

  Future<void> registerUser(
      String nickname, String email, String password) async {
    emit(LoadingUserState());
    try {
      final user = await UserRepository.createUser(nickname, email, password);
      emit(LoggedInState(user));
    } catch (error) {
      emit(ErrorUserState(error.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(LoadingUserState());
    try {
      final user = await UserRepository.login(email, password);
      if (user != null) {
        setUser(user);
        emit(LoggedInState(user));
      } else {
        emit(ErrorUserState('Invalid email or password'));
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'invalid-email':
            emit(ErrorUserState('Invalid email address'));
            break;
          case 'wrong-password':
            emit(ErrorUserState('Incorrect password'));
            break;
          default:
            emit(ErrorUserState('An error occurred. Please try again.'));
        }
      } else {
        emit(ErrorUserState(error.toString()));
      }
    }
  }

  Future<void> logout() async {
    emit(LoadingUserState());
    try {
      await UserRepository.logout();
      _currentUser = null;
      _userStreamController.sink.add(null);
      emit(LoggedOutState());
    } catch (error) {
      emit(ErrorUserState(error.toString()));
    }
  }

  @override
  Future<void> close() async {
    _userStreamController.close();
    super.close();
  }
}
