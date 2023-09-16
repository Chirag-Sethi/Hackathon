import 'package:flutter/material.dart';
import 'package:hackathon/core/constants/app_colors.dart';
import 'package:hackathon/core/constants/app_textstyles.dart';
import 'package:hackathon/core/responsive/size_config.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String? title;
  final double height;
  final double width;
  final Widget? widget;
  final TextStyle? textStyle;
  final bool? isLoading;
  final VoidCallback? onTap;
  final Color? disabledColor;
  final Color disabledBorderColor;
  const CustomButton({
    super.key,
    this.color = AppColors.red,
    this.title,
    this.textStyle,
    this.onTap,
    this.height = 48,
    this.width = double.maxFinite,
    this.widget,
    this.disabledColor = AppColors.neutral3,
    this.disabledBorderColor = AppColors.neutral5,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding:
          EdgeInsets.symmetric(vertical: 11 * SizeConfig.heightMultiplier!),
      height: height * SizeConfig.heightMultiplier!,
      minWidth: width * SizeConfig.widthMultiplier!,
      shape: onTap != null
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
              side: BorderSide(
                  color: disabledBorderColor,
                  width: 2 * SizeConfig.widthMultiplier!)),
      color: onTap == null ? null : color,
      onPressed: onTap,
      disabledColor: disabledColor,
      child: widget ??
          Text(
            title ?? "",
            style: (textStyle ?? AppTextStyles.f16W500White)
                .copyWith(color: onTap == null ? AppColors.textBlack40 : null),
          ),
    );
  }
}
