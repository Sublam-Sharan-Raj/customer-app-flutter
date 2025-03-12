import 'package:flutter/material.dart';
import 'package:insta_closet/app_colors.dart';

class RatingStarDisplay extends StatelessWidget {
  final int yellowStarCount;
  final int whiteStarCount;
  final double size;

  const RatingStarDisplay({
    super.key,
    this.yellowStarCount = 3,
    this.whiteStarCount = 2,
    this.size = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Display yellow stars
        ...List.generate(yellowStarCount, (index) {
          return Icon(
            Icons.star,
            color: AppColors.yellow,
            size: size,
          );
        }),
        // Display white stars
        ...List.generate(whiteStarCount, (index) {
          return Icon(
            Icons.star_border_rounded,
            color: Colors.grey,
            size: size,
          );
        }),
      ],
    );
  }
}
