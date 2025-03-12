import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/widgets/image_display.dart';
import 'package:insta_closet/widgets/rating_star_display.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key, this.title, this.description, this.price, this.imageUrl});

  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.grey,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align items to the start
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ImageDisplay(
              imageUrl: imageUrl ?? Constants.noImage,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title ?? "",
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\u{20B9}$price',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const RatingStarDisplay(yellowStarCount: 4, whiteStarCount: 0)
            ],
          ),
        ],
      ),
    );
  }
}
