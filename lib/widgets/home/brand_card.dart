import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/screens/brand_details.dart';
import 'package:insta_closet/widgets/image_display.dart';

class BrandCard extends StatelessWidget {
  const BrandCard(
      {super.key,
      required this.brandId,
      required this.imageUrl,
      required this.brandTitle,
      this.brandDescription,
      required this.time});
  final String brandId;
  final String imageUrl;
  final String brandTitle;
  final String? brandDescription;
  final String time;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BrandDetails(
                brandId: brandId, imageUrl: imageUrl, brandName: brandTitle)));
      },
      child: Column(
        children: [
          ImageDisplay(
            imageUrl: imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            applyImageRadius: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brandTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      brandDescription ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 8),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: AppColors.red,
                    size: 12,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    time,
                    style: GoogleFonts.lunasima(
                        fontWeight: FontWeight.w700,
                        fontSize: 8,
                        color: AppColors.red),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
