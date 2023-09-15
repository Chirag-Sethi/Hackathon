import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon/features/auth/Model/login_model.dart';
import 'package:hackathon/features/auth/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  void setState(AuthState state) {
    emit(state);
  }

  void resetState() {
    emit(AuthInitial());
  }

  final authRepositary = AuthRepositary();
  final getIt = GetIt.instance;

  LoginModel? loginModel;

  Future<void> setToken({String? token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token!);
  }

  Future<void> setUserType({String? userType, UserData? data}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType!);
    await prefs.setString('userDetails', jsonEncode(data?.toJson()));
  }

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final jsonresponse =
          await authRepositary.login(email: email, password: password);
      final response = LoginModel.fromJson(jsonresponse);
      getIt.get<UserData>().fromModel(response.userData!);
      log(getIt.get<UserData>().toJson().toString());
      loginModel = response;
      emit(LoginSuccessState(loginModel: response));
      await setToken(token: response.accessToken);
      // print(response.accessToken.toString());
      await setUserType(
          userType: (response.userData?.type?.type ?? ""),
          data: response.userData);
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['message'];
      emit(LoginFailedState(errorMessage: errorMessage));
    } catch (e) {
      emit(LoginFailedState(errorMessage: e.toString()));
    }
  }
}
