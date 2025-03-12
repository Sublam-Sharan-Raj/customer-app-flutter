import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/widgets/image_display.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider(
      {super.key,
      required this.banners,
      this.height = 150,
      this.viewportFraction = 1,
      this.showSlideIndicator = true,
      this.scale = 1});

  final List<String> banners;
  final double height;
  final double viewportFraction;
  final double scale;
  final bool showSlideIndicator;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(viewportFraction: viewportFraction);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),

          height: height, // Adjust height as needed
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    final url = banners[index];
                    return Transform.scale(
                      scale: scale,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        url,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                            child: Text(
                                              'Failed to load image',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.black54,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: ImageDisplay(
                          imageUrl: url,
                          applyImageRadius: true,
                          height: height,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16), // Space between carousel and indicator
              SmoothPageIndicator(
                controller: pageController,
                count: banners.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                  activeDotColor: AppColors.secondary,
                  dotColor: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CarouselController extends GetxController {
  final Rx<int> carouselIndex = 0.obs;

  void updateCarouselIndex(index) {
    carouselIndex.value = index;
  }
}
