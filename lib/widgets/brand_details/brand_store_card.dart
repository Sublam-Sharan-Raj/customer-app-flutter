import 'package:flutter/material.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/product_list/product_list_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/screens/brand_store_details.dart';
import 'package:insta_closet/widgets/image_display.dart';
import 'package:insta_closet/widgets/rating_star_display.dart';

class BrandStoreCard extends StatelessWidget {
  const BrandStoreCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.location,
      required this.storeCloseTime,
      this.onActionPressed,
      required this.brandId,
      required this.storeId});

  final String title;
  final String imageUrl;
  final String location;
  final String storeCloseTime;
  final String brandId;
  final String storeId;

  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BrandStoreDetails(
                  id: brandId,
                  storeId: storeId,
                  source: ProductSource.brand.name,
                )));
      },
      child: Card(
        elevation: 2,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageDisplay(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: 60,
                height: 60,
                clipOval: true,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: location,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: 9,

                                  color:
                                      Colors.black, // Set text color to black
                                ),
                          ),
                          TextSpan(
                            text: storeCloseTime,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  // Set time color to red
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Delivery up to ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      fontSize: 7,
                                      fontWeight: FontWeight.w700,
                                      color: Colors
                                          .black, // Set text color to black
                                    ),
                              ),
                              TextSpan(
                                text: "01 hr 52 min",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      fontSize: 7,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors
                                          .secondary, // Set time color to red
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const RatingStarDisplay()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
