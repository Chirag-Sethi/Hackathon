import 'package:hackathon/features/home/model/get_model_response.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetOrgainzationLoadingState extends HomeState {}

class GetOrgainzationSuccessState extends HomeState {
  final List<Datum> data;

  GetOrgainzationSuccessState(this.data);
}

class GetOrgainzationFailedState extends HomeState {
  final String errorText;
  GetOrgainzationFailedState(this.errorText);
}

class CheckDonateButtonState extends HomeState {}

class CreateOrderLoadingState extends HomeState {}

class CreateOrderSuccessState extends HomeState {}

class CreateOrderFailedState extends HomeState {
  final String errorText;
  CreateOrderFailedState(this.errorText);
}
