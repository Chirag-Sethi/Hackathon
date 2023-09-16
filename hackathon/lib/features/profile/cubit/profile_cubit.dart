import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/features/profile/cubit/profile_state.dart';
import 'package:hackathon/features/profile/model/profile_model.dart';

import '../repository/profile_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final ProfileRepository _profileRepository = ProfileRepository();

  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController states = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  ProfileModel? data;

  bool isEdit = false;

  bool signUpButtonEnable = false;
  bool signupObstructText = true;

  void setState(ProfileState state) {
    emit(state);
  }

  void enableEdit() {
    isEdit = !isEdit;
    emit(ProfileEditState());
  }

  Future<void> getProfile() async {
    try {
      emit(ProfileLoadingState());
      final response = await _profileRepository.getProfile();
      final dataResponse = ProfileModel.fromJson(response);
      data = dataResponse;
      getdata();
      emit(ProfileSuccessState());
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['message'];
      emit(ProfileFailedState(errorMessage));
    } catch (e) {
      emit(ProfileFailedState(e.toString()));
    }
  }

  Future<void> updateProfile() async {
    try {
      emit(ProfileUpdateLoadingState());
      await _profileRepository.profileUpdate(
          email: email.text,
          address: address.text,
          name: name.text,
          mobile: mobile.text,
          city: city.text,
          pincode: pincode.text,
          state: states.text);
      isEdit = false;
      emit(ProfileUpdateSuccessState());
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['message'];
      emit(ProfileUpdateFailedState(errorMessage));
    } catch (e) {
      emit(ProfileUpdateFailedState(e.toString()));
    }
  }

  getdata() {
    email.text = data?.data?.email ?? "";
    mobile.text = data?.data?.mobile ?? "";
    states.text = data?.data?.state ?? "";
    city.text = data?.data?.city ?? "";
    name.text = data?.data?.name ?? "";
    address.text = data?.data?.address ?? "";
    pincode.text = data?.data?.pincode.toString() ?? "";
  }
}
