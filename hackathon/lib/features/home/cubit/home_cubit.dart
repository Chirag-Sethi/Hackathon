import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/features/home/cubit/home_state.dart';
import 'package:hackathon/features/home/model/get_model_response.dart';
import 'package:hackathon/features/home/repository/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomeRepository _homeRepository = HomeRepository();
  TextEditingController amount = TextEditingController();
  bool buttonEnable = false;

  Datum? selectedVal;

  Future<void> getOrgainzation() async {
    try {
      emit(GetOrgainzationLoadingState());
      final response = await _homeRepository.organizationList();
      final data = OrganizationModel.fromJson(response);
      emit(GetOrgainzationSuccessState(data.data ?? []));
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['message'];
      emit(GetOrgainzationFailedState(errorMessage));
    } catch (e) {
      emit(GetOrgainzationFailedState(e.toString()));
    }
  }

  convertStringToInt() {}

  checkButton() {
    if (selectedVal != null && amount.text.isNotEmpty) {
      buttonEnable = true;
      emit(CheckDonateButtonState());
    } else {
      buttonEnable = false;
      emit(CheckDonateButtonState());
    }
  }

  Future<void> createOrder() async {
    try {
      emit(CreateOrderLoadingState());
      final int money = (int.tryParse(amount.text) ?? 0) * 100;
      await _homeRepository.createOrder(
          id: selectedVal?.id ?? "", amount: money);
      emit(CreateOrderSuccessState());
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['message'];
      emit(CreateOrderFailedState(errorMessage));
    } catch (e) {
      emit(CreateOrderFailedState(e.toString()));
    }
  }
}
