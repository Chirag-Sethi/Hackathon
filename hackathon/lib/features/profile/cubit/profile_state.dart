import 'package:hackathon/features/profile/model/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ShowPassword extends ProfileState {}

class SignUpShowPassword extends ProfileState {}

class ProfileButtonActivate extends ProfileState {
  final bool isActivate;
  ProfileButtonActivate(this.isActivate);
}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {}

class ProfileFailedState extends ProfileState {
  final String errorText;
  ProfileFailedState(this.errorText);
}

class ProfileUpdateLoadingState extends ProfileState {}

class ProfileUpdateSuccessState extends ProfileState {}

class ProfileUpdateFailedState extends ProfileState {
  final String errorText;
  ProfileUpdateFailedState(this.errorText);
}

class ProfileEditState extends ProfileState {}
