import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/core/constants/app_colors.dart';
import 'package:hackathon/core/constants/app_textstyles.dart';
import 'package:hackathon/core/responsive/size_config.dart';
import 'package:hackathon/features/home/model/get_model_response.dart';

class CustomDropDownFilter extends StatelessWidget {
  const CustomDropDownFilter({
    required this.labelTitle,
    this.hintText,
    required this.onChanged,
    required this.selectedValue,
    required this.context,
    required this.listofitems,
    this.validation,
    this.formKey,
    this.autovalidateMode,
    super.key,
    this.height,
    required this.itemLabelFormat,
  });

  final String? labelTitle;
  final String? hintText;
  final void Function(String?)? onChanged;
  final String? selectedValue;
  final Key? formKey;
  final String? Function(String?)? validation;
  final List<dynamic>? listofitems;
  final BuildContext context;
  final double? height;
  final String Function(Datum) itemLabelFormat;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelTitle!,
            style: AppTextStyles.f14W400TextBlack,
          ),
          SizedBox(
            height: 5 * SizeConfig.heightMultiplier!,
          ),
          // drop down
          DropdownButtonFormField2(
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 150,
              elevation: 1,
              padding: EdgeInsets.zero,
            ),
            isExpanded: true,
            isDense: true,
            validator: validation,
            autovalidateMode:
                autovalidateMode ?? AutovalidateMode.onUserInteraction,
            style: AppTextStyles.f16W400TextBlack,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 3 * SizeConfig.heightMultiplier!,
                  horizontal: 5 * SizeConfig.widthMultiplier!),
              isDense: true,
              filled: true,
              fillColor: AppColors.neutral3,
              focusColor: AppColors.red,
              hoverColor: AppColors.red,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1 * SizeConfig.widthMultiplier!,
                      color: AppColors.red),
                  borderRadius: BorderRadius.circular(2)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1 * SizeConfig.widthMultiplier!,
                      color: AppColors.red),
                  borderRadius: BorderRadius.circular(2)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1 * SizeConfig.widthMultiplier!,
                      color: AppColors.red),
                  borderRadius: BorderRadius.circular(2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1 * SizeConfig.widthMultiplier!,
                      color: AppColors.neutral5),
                  borderRadius: BorderRadius.circular(2)),
            ),
            hint: Text(
              hintText ?? 'Select One',
              style: AppTextStyles.f16W400White40,
            ),
            iconStyleData: IconStyleData(
                icon: Padding(
              padding: EdgeInsets.only(right: 10 * SizeConfig.widthMultiplier!),
              child: const Icon(Icons.arrow_drop_down),
            )),
            items: (listofitems ?? []).map((item) {
              return DropdownMenuItem<String>(
                value: (item as Datum).id,
                child: SizedBox(
                  width: 225 * SizeConfig.widthMultiplier!,
                  child: Text(itemLabelFormat(item),
                      style: AppTextStyles.f16W400TextBlack),
                ),
              );
            }).toList(),
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.zero,
              height: 40 * SizeConfig.heightMultiplier!,
            ),
            value: selectedValue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
