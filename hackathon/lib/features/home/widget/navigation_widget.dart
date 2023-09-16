import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hackathon/core/constants/app_colors.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(
          icon: Icon(Icons.volunteer_activism),
          label: "Donation",
          activeIcon: Icon(
            Icons.volunteer_activism,
            color: AppColors.black,
          )),
      BottomNavigationBarItem(
        icon: Icon(Icons.receipt_long),
        label: "Transaction",
        activeIcon: Icon(
          Icons.receipt_long,
          color: AppColors.black,
        ),
      ),
    ]);
  }
}
