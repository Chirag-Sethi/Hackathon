abstract class LoginState {}

class LoginInitial extends LoginState {}

class ShowPassword extends LoginState {}

class SignUpShowPassword extends LoginState {}

class LoginButtonActivate extends LoginState {
  final bool isActivate;
  LoginButtonActivate(this.isActivate);
}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailedState extends LoginState {
  final String errorText;
  LoginFailedState(this.errorText);
}

class SignUpLoadingState extends LoginState {}

class SignUpSuccessState extends LoginState {}

class SignUpFailedState extends LoginState {
  final String errorText;
  SignUpFailedState(this.errorText);
}

class SignUpButtonActivate extends LoginState {
  final bool isActivate;
  SignUpButtonActivate(this.isActivate);
}

class CheckPasswordState extends LoginState {
  final String error;
  CheckPasswordState(this.error);
}

class SignupCheckPasswordState extends LoginState {
  final String error;
  SignupCheckPasswordState(this.error);
}

class CheckMobileNumberState extends LoginState {
  final String error;
  CheckMobileNumberState(this.error);
}
