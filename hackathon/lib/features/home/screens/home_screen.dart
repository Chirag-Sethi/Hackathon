import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/common/widgets/common_textfeild.dart';
import 'package:hackathon/common/widgets/custom_button.dart';
import 'package:hackathon/core/auth/auth_repository.dart';
import 'package:hackathon/core/constants/app_colors.dart';
import 'package:hackathon/core/constants/app_textstyles.dart';
import 'package:hackathon/core/constants/image_path.dart';
import 'package:hackathon/core/local_storage/secure_storage.dart';
import 'package:hackathon/core/responsive/size_config.dart';
import 'package:hackathon/core/routes/named_routes.dart';
import 'package:hackathon/core/routes/navigator.dart';
import 'package:hackathon/features/home/cubit/home_cubit.dart';
import 'package:hackathon/features/home/model/get_model_response.dart';
import 'package:hackathon/features/home/widget/custom_dropdown.dart';
import 'package:hackathon/features/login/cubit/login_cubit.dart';
import 'package:lottie/lottie.dart';

import '../cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;
  List<Datum> data = [];

  @override
  void initState() {
    super.initState();
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _homeCubit.getOrgainzation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: GestureDetector(
          //     onTap: () {
          //       AnywhereDoor.pushNamed(context,
          //           routeName: RouteName.profileScreen);
          //     },
          //     child: Padding(
          //       padding:
          //           EdgeInsets.only(right: 18 * SizeConfig.widthMultiplier!),
          //       child: const Icon(Icons.account_circle_rounded),
          //     )),
          actions: [
            GestureDetector(
                onTap: () {
                  AnywhereDoor.pushNamed(context,
                      routeName: RouteName.profileScreen);
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 18 * SizeConfig.widthMultiplier!),
                  child: const Icon(Icons.account_circle_rounded),
                )),
          ]),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetOrgainzationSuccessState) {
            data = state.data;
          }
          if (state is GetOrgainzationFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Something went wrong",
                style: AppTextStyles.f12W400White,
              ),
              backgroundColor: AppColors.black,
            ));
          }
          if (state is CreateOrderFailedState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: LottieBuilder.asset(ImagePath.someWentWrong),
                );
              },
            );
          }
          if (state is CreateOrderSuccessState) {
            _homeCubit.selectedVal = null;
            data.clear();
            _homeCubit.amount.clear();
            _homeCubit.checkButton();
            _homeCubit.getOrgainzation();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: LottieBuilder.asset(ImagePath.successful),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              20 * SizeConfig.widthMultiplier!,
              50 * SizeConfig.heightMultiplier!,
              20 * SizeConfig.widthMultiplier!,
              20 * SizeConfig.heightMultiplier!,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomDropDownFilter(
                  labelTitle: "Orgainzation",
                  onChanged: (val) {
                    if (val != null) {
                      _homeCubit.selectedVal =
                          data.singleWhere((element) => element.id == val);
                      _homeCubit.checkButton();
                    }
                  },
                  selectedValue: _homeCubit.selectedVal?.id,
                  context: context,
                  listofitems: data,
                  itemLabelFormat: (item) {
                    return item.name ?? "";
                  }),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 20 * SizeConfig.heightMultiplier!),
                child: CustomTextfield(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  hintText: "Enter the amount",
                  controller: _homeCubit.amount,
                  wantLabel: true,
                  label: "Amount",
                  onChanged: (_) {
                    _homeCubit.checkButton();
                  },
                ),
              ),
              const Spacer(),
              CustomButton(
                widget: Text(
                  "Donate",
                  style: AppTextStyles.f14W500White,
                ),
                onTap: _homeCubit.buttonEnable
                    ? () {
                        _homeCubit.createOrder();
                      }
                    : null,
              )
            ]),
          );
        },
      ),
    );
  }
}
