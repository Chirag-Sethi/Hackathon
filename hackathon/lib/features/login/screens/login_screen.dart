import 'package:flutter/material.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit _loginCubit;
  bool buttonEnable = false;
  String? errorText;
  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of<LoginCubit>(context);
    // _loginCubit.checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 17 * SizeConfig.widthMultiplier!),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailedState) {
                errorText = state.errorText;
              }
              if (state is LoginButtonActivate) {
                buttonEnable = state.isActivate;
              }
              if (state is LoginSuccessState) {
                AnywhereDoor.pushNamed(context,
                    routeName: RouteName.homeScreen);
              }
              if (state is CheckPasswordState) {
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
                  // ignore: prefer_const_constructors
                  Text(
                    "Welcome Back!",
                    style: AppTextStyles.f24W400TextBlackMr,
                  ),
                  SizedBox(
                    height: 33 * SizeConfig.heightMultiplier!,
                  ),
                  CustomTextfield(
                    onChanged: (value) {
                      _loginCubit.isLoginButtonEnable();
                    },
                    keyboardType: TextInputType.emailAddress,
                    hintText: "User id",
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                    // ],
                    backgroundColor: AppColors.white,
                    controller: _loginCubit.userId,
                  ),

                  SizedBox(height: 26 * SizeConfig.heightMultiplier!),

                  CustomTextfield(
                    onChanged: (value) {
                      _loginCubit.isLoginButtonEnable();
                      _loginCubit.checkPasword(forLogin: true);
                    },
                    hintText: "Password",
                    backgroundColor: AppColors.white,
                    controller: _loginCubit.password,
                    obscureText: _loginCubit.obstructText,
                    suffix: GestureDetector(
                        onTap: () {
                          _loginCubit.showPassword();
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
                  if (errorText != null && errorText != "")
                    Text(
                      errorText ?? "",
                      style: AppTextStyles.f12W400Red,
                    ),

                  SizedBox(
                    height: 32 * SizeConfig.heightMultiplier!,
                  ),

                  RichText(
                      // ignore: prefer_const_constructors
                      text: TextSpan(
                          text: "By Sign up In you agree to our ",
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
                    height: 16 * SizeConfig.heightMultiplier!,
                  ),
                  CustomButton(
                      widget: BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return const CircularProgressIndicator();
                          }
                          return Text("Log in",
                              style: AppTextStyles.f16W500White);
                        },
                      ),
                      onTap: buttonEnable == true
                          ? () {
                              _loginCubit.login();
                            }
                          : null),

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
                            SizeConfig.widthMultiplier!, // width size problem
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
                            SizeConfig.widthMultiplier!, // width size problem
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16 * SizeConfig.heightMultiplier!,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "New to WellFund? ",
                          style: AppTextStyles.f14W400TextBlack,
                          children: [
                        WidgetSpan(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteName.signupScreen);
                                },
                                child: Text("Sign Up",
                                    style: AppTextStyles.f14W500Red)))
                      ])),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
