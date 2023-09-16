import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hackathon/core/auth/auth_repository.dart';
import 'package:hackathon/core/routes/named_routes.dart';
import 'package:hackathon/core/routes/navigator.dart';
import 'package:hackathon/features/login/cubit/login_state.dart';
import 'package:hackathon/features/login/models/login_model.dart';
import 'package:hackathon/features/login/repository/login_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final LoginRepository _loginRepository = LoginRepository();

  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController signUpEmailId = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController signUpName = TextEditingController();
  TextEditingController signupMobile = TextEditingController();

  bool obstructText = true;
  bool loginButtonEnable = false;
  bool signUpButtonEnable = false;
  bool signupObstructText = true;

  void showPassword() {
    obstructText = !obstructText;
    emit(ShowPassword());
  }

  void signUpShowPassword() {
    obstructText = !obstructText;
    emit(SignUpShowPassword());
  }

  isLoginButtonEnable() {
    if (userId.text.isNotEmpty &&
        (password.text.length >= 8 && loginButtonEnable == false)) {
      loginButtonEnable = true;
      emit(LoginButtonActivate(loginButtonEnable));
    } else if ((userId.text.isEmpty || password.text.isEmpty) &&
        (loginButtonEnable == true || loginButtonEnable == false)) {
      loginButtonEnable = false;
      emit(LoginButtonActivate(loginButtonEnable));
    }
  }

  checkPasword({required bool forLogin}) {
    if (forLogin == true) {
      if (password.text.length < 8) {
        emit(CheckPasswordState(
            "Password must be greater and equal to 8 characters"));
      } else {
        emit(CheckPasswordState(""));
      }
    } else {
      if (signUpPassword.text.length < 8) {
        emit(SignupCheckPasswordState(
            "Password must be greater and equal to 8 characters"));
      } else {
        emit(SignupCheckPasswordState(""));
      }
    }
  }

  checkMobileNumber() {
    if (signupMobile.text.length == 10) {
      emit(CheckMobileNumberState(""));
    } else {
      emit(CheckMobileNumberState(
          "Mobile number must be equal to 10 characters"));
    }
  }

  isSignButtonEnable() {
    if (signUpEmailId.text.isNotEmpty &&
        (signUpPassword.text.isNotEmpty &&
            signUpButtonEnable == false &&
            signUpName.text.isNotEmpty)) {
      signUpButtonEnable = true;
      emit(SignUpButtonActivate(signUpButtonEnable));
    } else if ((signUpEmailId.text.isEmpty ||
            signUpPassword.text.isEmpty ||
            signupMobile.text.isEmpty ||
            signUpName.text.isEmpty) &&
        (signUpButtonEnable == true || signUpButtonEnable == false)) {
      signUpButtonEnable = false;
      emit(SignUpButtonActivate(signUpButtonEnable));
    }
  }

  void signup() {
    try {
      emit(SignUpLoadingState());
      _loginRepository.signUp(
          mobile: signupMobile.text,
          email: signUpEmailId.text,
          password: signUpPassword.text,
          name: signUpName.text);
      emit(SignUpSuccessState());
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['message'];
      emit(SignUpFailedState(errorMessage));
    } catch (e) {
      emit(SignUpFailedState(e.toString()));
    }
  }

  Future<void> login() async {
    try {
      emit(LoginLoadingState());
      final response = await _loginRepository.login(
        email: userId.text,
        password: password.text,
      );
      final data = LoginModel.fromJson(response);
      AuthRepository.instance.setAccessToken(data.data?.token ?? "");
      emit(LoginSuccessState());
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['message'];
      emit(LoginFailedState(errorMessage));
    } catch (e) {
      emit(LoginFailedState(e.toString()));
    }
  }

  checkAuth(BuildContext context) async {
    await AuthRepository.instance.init();
    final accessToken = AuthRepository.accessToken;
    if (accessToken != null) {
      AnywhereDoor.pushReplacementNamed(context,
          routeName: RouteName.homeScreen);
    } else {
      AnywhereDoor.pushReplacementNamed(context,
          routeName: RouteName.loginScreen);
    }
  }
}
