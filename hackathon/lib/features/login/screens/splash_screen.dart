import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon/core/constants/image_path.dart';
import 'package:hackathon/core/responsive/size_config.dart';

import '../cubit/login_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of<LoginCubit>(context);
    _loginCubit.checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 300 * SizeConfig.heightMultiplier!,
              width: 300 * SizeConfig.widthMultiplier!,
              child: SvgPicture.asset(ImagePath.someWentWrong))
        ],
      ),
    );
  }
}
