import 'package:flutter/material.dart';
import 'package:insta_closet/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? handleNavigation;

  // Constructor allows customization of icon and background color
  const CustomBackButton({super.key, this.handleNavigation});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        decoration: const BoxDecoration(
          color: AppColors.grey,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(
          size: 16,
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
      onPressed: handleNavigation ??
          () {
            Navigator.pop(context);
          },
    );
  }
}
