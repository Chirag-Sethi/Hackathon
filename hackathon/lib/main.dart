import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon/core/constants/app_colors.dart';
import 'package:hackathon/core/responsive/size_config.dart';
import 'package:hackathon/core/routes/named_routes.dart';

import 'package:hackathon/features/Login/screens/Login_screen.dart';
import 'package:hackathon/features/home/cubit/home_cubit.dart';

import 'package:hackathon/features/login/cubit/login_cubit.dart';
import 'package:hackathon/features/profile/cubit/profile_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
      ],
      child: ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: const Size(360, 800),
          minTextAdapt: true,
          builder: (BuildContext context, Widget? child) {
            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                SizeConfig().init(constraints, orientation);
                return MaterialApp(
                  title: 'WellFound',
                  onGenerateRoute: GenerateRoute.generateRoute,
                  initialRoute: '/',
                  debugShowCheckedModeBanner: false,
                  home: const LoginScreen(),
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(color: AppColors.red),
                    fontFamily: 'Inter Default',
                  ),
                );
              });
            });
          }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
