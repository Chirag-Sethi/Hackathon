import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon/core/constants/app_colors.dart';
import 'package:hackathon/core/constants/app_textstyles.dart';
import 'package:hackathon/core/responsive/size_config.dart';

class CustomTextfield extends StatelessWidget {
  final Color? focusedBorderColor;
  final String hintText;
  final Color backgroundColor;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffix;
  final TextStyle? hintTextStyle;
  final TextStyle? style;
  final Function(String?)? onChanged;
  final BorderRadius? enableFocusedBorderRadius;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? readonly;
  final bool? isAutoValidate;
  final String? suffixText;
  final bool? wantLabel;
  final String? label;
  final bool? enabled;

  const CustomTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      this.backgroundColor = AppColors.neutral3,
      this.obscureText = false,
      this.suffix,
      this.onChanged,
      this.keyboardType,
      this.validator,
      this.inputFormatters,
      this.enableFocusedBorderRadius,
      this.focusedBorderColor,
      this.hintTextStyle,
      this.suffixText,
      this.style,
      this.readonly = false,
      this.isAutoValidate,
      this.wantLabel,
      this.label,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (wantLabel == true)
          Text(
            label ?? "",
            style: AppTextStyles.f14W400TextBlack,
          ),
        if (wantLabel == true)
          SizedBox(
            height: 5 * SizeConfig.heightMultiplier!,
          ),
        TextFormField(
          readOnly: readonly ?? false,
          autovalidateMode: isAutoValidate ?? false
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          controller: controller,
          obscureText: obscureText,
          obscuringCharacter: "*",
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: style ?? AppTextStyles.f16W400TextBlack,
          decoration: InputDecoration(
              suffix: suffix,
              enabled: enabled ?? true,
              hintText: hintText,
              suffixText: suffixText,
              suffixStyle: style ?? AppTextStyles.f16W400TextBlack,
              hintStyle: hintTextStyle ?? AppTextStyles.f16W400White40,
              filled: true,
              focusColor: AppColors.white,
              fillColor: backgroundColor,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1 * SizeConfig.widthMultiplier!,
                      color: focusedBorderColor ?? AppColors.red),
                  borderRadius: BorderRadius.circular(2)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1 * SizeConfig.widthMultiplier!,
                      color: focusedBorderColor ?? AppColors.red),
                  borderRadius: BorderRadius.circular(2)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1 * SizeConfig.widthMultiplier!,
                      color: focusedBorderColor ?? AppColors.red),
                  borderRadius: BorderRadius.circular(2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1 * SizeConfig.widthMultiplier!,
                      color: AppColors.neutral5),
                  borderRadius:
                      enableFocusedBorderRadius ?? BorderRadius.circular(2)),
              counterStyle: AppTextStyles.f12W400Nickel,
              contentPadding: EdgeInsets.symmetric(
                  vertical: 7 * SizeConfig.heightMultiplier!,
                  horizontal: 12 * SizeConfig.widthMultiplier!),
              border: InputBorder.none),
        ),
      ],
    );
  }
}
