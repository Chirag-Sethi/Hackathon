import 'package:hackathon/features/auth/Model/login_model.dart';

abstract class AuthState{}

class AuthInitial extends AuthState{}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final LoginModel loginModel;
  LoginSuccessState({
    required this.loginModel,
  });
}

class LoginErrorState extends AuthState {
  final String? passwordError;
  final String? emailError;
  LoginErrorState({this.passwordError, this.emailError});
}

class LoginFailedState extends AuthState {
  final String errorMessage;
  LoginFailedState({required this.errorMessage});
}