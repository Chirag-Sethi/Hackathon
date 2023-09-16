import 'package:flutter/material.dart';
import 'package:hackathon/core/constants/app_colors.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: AppColors.white,
      backgroundColor: AppColors.neutral6,
    ));
  }
}
