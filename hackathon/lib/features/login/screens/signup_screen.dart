import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/common/widgets/common_textfeild.dart';
import 'package:hackathon/common/widgets/custom_button.dart';
import 'package:hackathon/core/constants/app_colors.dart';
import 'package:hackathon/core/constants/app_textstyles.dart';
import 'package:hackathon/core/responsive/size_config.dart';
import 'package:hackathon/core/routes/named_routes.dart';
import 'package:hackathon/core/routes/navigator.dart';
import 'package:hackathon/features/login/cubit/login_cubit.dart';
import 'package:hackathon/features/login/cubit/login_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late LoginCubit _loginCubit;
  bool buttonEnable = false;
  String errorText = "";
  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of<LoginCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SignUpFailedState) {
            errorText = state.errorText;
          }
          if (state is SignUpSuccessState) {
            AnywhereDoor.pushNamed(context, routeName: RouteName.loginScreen);
          }
          if (state is SignUpButtonActivate) {
            buttonEnable = state.isActivate;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 17 * SizeConfig.widthMultiplier!),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is SignUpFailedState) {
                    errorText = state.errorText;
                  }
                  if (state is CheckMobileNumberState) {
                    errorText = state.error;
                  }
                  if (state is CheckPasswordState) {
                    errorText = state.error;
                  }
                  if (state is SignupCheckPasswordState) {
                    errorText = state.error;
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 104 * SizeConfig.heightMultiplier!,
                      ),
                      Text(
                        "Welcome To WellFund",
                        style: AppTextStyles.f24W400TextBlackMr,
                      ),
                      SizedBox(
                        height: 33 * SizeConfig.heightMultiplier!,
                      ),
                      CustomTextfield(
                        onChanged: (value) {
                          _loginCubit.isSignButtonEnable();
                        },
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email Id",
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                        // ],
                        backgroundColor: AppColors.white,
                        controller: _loginCubit.signUpEmailId,
                      ),
                      SizedBox(height: 26 * SizeConfig.heightMultiplier!),
                      CustomTextfield(
                        onChanged: (value) {
                          _loginCubit.isSignButtonEnable();
                        },
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Username",
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                        // ],
                        backgroundColor: AppColors.white,
                        controller: _loginCubit.signUpName,
                      ),
                      SizedBox(height: 26 * SizeConfig.heightMultiplier!),
                      CustomTextfield(
                        onChanged: (value) {
                          _loginCubit.isSignButtonEnable();
                          _loginCubit.checkMobileNumber();
                        },
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Mobile Number",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                        backgroundColor: AppColors.white,
                        controller: _loginCubit.signupMobile,
                      ),
                      SizedBox(height: 26 * SizeConfig.heightMultiplier!),
                      CustomTextfield(
                        onChanged: (value) {
                          _loginCubit.isSignButtonEnable();
                          _loginCubit.checkPasword(forLogin: false);
                        },
                        hintText: "Password",
                        backgroundColor: AppColors.white,
                        controller: _loginCubit.signUpPassword,
                        obscureText: _loginCubit.obstructText,
                        suffix: GestureDetector(
                            onTap: () {
                              _loginCubit.signUpShowPassword();
                            },
                            child: Icon(
                              _loginCubit.obstructText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 22 * SizeConfig.imageSizeMultiplier!,
                            )),
                      ),
                      SizedBox(
                        height: 17 * SizeConfig.heightMultiplier!,
                      ),
                      Text(
                        errorText,
                        style: AppTextStyles.f12W400Red,
                      ),
                      RichText(
                          // ignore: prefer_const_constructors
                          text: TextSpan(
                              text: "By Signing In you agree to our ",
                              style: AppTextStyles.f12W400Nickel,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                            TextSpan(
                              text: "Terms and Conditions",
                              style: AppTextStyles.f12W400TextBlack,
                            ),
                            TextSpan(
                              text: " and ",
                              style: AppTextStyles.f12W400Nickel,
                            ),
                            TextSpan(
                              text: "Privacy Policy",
                              style: AppTextStyles.f12W400TextBlack,
                            ),
                          ])),
                      SizedBox(
                        height: 32 * SizeConfig.heightMultiplier!,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state is SignUpButtonActivate) {
                            buttonEnable = state.isActivate;
                          }
                          return CustomButton(
                              widget: BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) {
                                  if (state is SignUpLoadingState) {
                                    return const CircularProgressIndicator();
                                  }
                                  return Text("Sign Up",
                                      style: AppTextStyles.f16W500White);
                                },
                              ),
                              onTap: buttonEnable == true
                                  ? () {
                                      _loginCubit.signup();
                                    }
                                  : null);
                        },
                      ),
                      SizedBox(
                        height: 32 * SizeConfig.heightMultiplier!,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 1 * SizeConfig.heightMultiplier!,
                            color: AppColors.neutral5,
                            width: MediaQuery.of(context).size.width /
                                2.9 *
                                SizeConfig
                                    .widthMultiplier!, // width size problem
                          ),
                          SizedBox(
                            width: 8 * SizeConfig.widthMultiplier!,
                          ),
                          Text(
                            "OR",
                            style: AppTextStyles.f16W500Neutral7,
                          ),
                          SizedBox(
                            width: 8 * SizeConfig.widthMultiplier!,
                          ),
                          Container(
                            height: 1 * SizeConfig.heightMultiplier!,
                            color: AppColors.neutral5,
                            width: MediaQuery.of(context).size.width /
                                2.9 *
                                SizeConfig
                                    .widthMultiplier!, // width size problem
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16 * SizeConfig.heightMultiplier!,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Already you have a account? ",
                              style: AppTextStyles.f14W400TextBlack,
                              children: [
                            WidgetSpan(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.loginScreen);
                                    },
                                    child: Text("Log in",
                                        style: AppTextStyles.f14W500Red)))
                          ])),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
