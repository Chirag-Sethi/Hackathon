import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/common/widgets/common_textfeild.dart';
import 'package:hackathon/common/widgets/custom_button.dart';
import 'package:hackathon/core/constants/app_colors.dart';
import 'package:hackathon/core/constants/app_textstyles.dart';
import 'package:hackathon/core/responsive/size_config.dart';

import 'package:hackathon/features/profile/cubit/profile_cubit.dart';
import 'package:hackathon/features/profile/cubit/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = BlocProvider.of<ProfileCubit>(context);
    _profileCubit.getProfile();
    _profileCubit.isEdit = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Profile",
              style: AppTextStyles.f16W400TextWhite,
            ),
            actions: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      _profileCubit.enableEdit();
                    },
                    child: Text(
                      _profileCubit.isEdit == true ? "Cancel" : "Edit",
                      style: AppTextStyles.f16W400TextWhite,
                    ),
                  );
                },
              ),
            ],
          ),
          body: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileFailedState) {}
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20 * SizeConfig.widthMultiplier!,
                      vertical: 20 * SizeConfig.heightMultiplier!),
                  child: Column(
                    children: [
                      CustomTextfield(
                        enabled: _profileCubit.isEdit,
                        wantLabel: true,
                        keyboardType: TextInputType.name,
                        hintText: "Username",
                        label: "Username",
                        backgroundColor: AppColors.white,
                        controller: _profileCubit.name,
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      CustomTextfield(
                        enabled: _profileCubit.isEdit,
                        wantLabel: true,
                        label: "Email",
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email",
                        backgroundColor: AppColors.white,
                        controller: _profileCubit.email,
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      CustomTextfield(
                        enabled: _profileCubit.isEdit,
                        wantLabel: true,
                        label: "Mobile number",
                        keyboardType: TextInputType.number,
                        hintText: "Mobile number",
                        backgroundColor: AppColors.white,
                        controller: _profileCubit.mobile,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      CustomTextfield(
                        enabled: _profileCubit.isEdit,
                        wantLabel: true,
                        label: "Address",
                        keyboardType: TextInputType.streetAddress,
                        hintText: "Address",
                        backgroundColor: AppColors.white,
                        controller: _profileCubit.address,
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      CustomTextfield(
                        enabled: _profileCubit.isEdit,
                        wantLabel: true,
                        label: "City",
                        keyboardType: TextInputType.streetAddress,
                        hintText: "City",
                        backgroundColor: AppColors.white,
                        controller: _profileCubit.city,
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      CustomTextfield(
                        enabled: _profileCubit.isEdit,
                        wantLabel: true,
                        label: "State",
                        keyboardType: TextInputType.name,
                        hintText: "State",
                        backgroundColor: AppColors.white,
                        controller: _profileCubit.states,
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      CustomTextfield(
                        enabled: _profileCubit.isEdit,
                        wantLabel: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                        label: "Pincode",
                        keyboardType: TextInputType.number,
                        hintText: "Pincode",
                        backgroundColor: AppColors.white,
                        controller: _profileCubit.pincode,
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      if (_profileCubit.isEdit == true)
                        CustomButton(
                            widget: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            if (state is ProfileLoadingState) {
                              return const CircularProgressIndicator();
                            }
                            return Text("Update",
                                style: AppTextStyles.f16W500White);
                          },
                        ), onTap: () {
                          _profileCubit.updateProfile();
                        }),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
