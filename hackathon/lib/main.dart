import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon/core/responsive/size_config.dart';
import 'package:hackathon/features/auth/cubit/auth_cubit.dart';
import 'package:hackathon/features/auth/screens/login_screen.dart';

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
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
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
                  title: 'Hack',
                  debugShowCheckedModeBanner: false,
                  home: const LoginScreen(),
                  theme: ThemeData(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    // primarySwatch: AppColors.kPrimarySwatch,
                    // canvasColor: AppColors.kPureWhite,
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
