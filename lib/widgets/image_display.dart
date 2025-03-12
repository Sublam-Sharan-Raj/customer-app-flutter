import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay(
      {super.key,
      this.width,
      this.height,
      required this.imageUrl,
      this.applyImageRadius = false,
      this.fit = BoxFit.cover, // Default to BoxFit.cover
      this.onPressed,
      this.borderRadius = 10,
      this.clipOval = false});

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxFit? fit;
  final VoidCallback? onPressed;
  final double borderRadius;
  final bool clipOval;

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = Uri.tryParse(imageUrl)?.hasAbsolutePath ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: clipOval
            ? ClipOval(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // if (isNetworkImage)
                    //   Shimmer.fromColors(
                    //     baseColor: Colors.grey[300]!,
                    //     highlightColor: Colors.grey[100]!,
                    //     child: Container(
                    //       width: double.infinity,
                    //       height: 200,
                    //       decoration: const BoxDecoration(
                    //         borderRadius: BorderRadius.all(Radius.circular(10)),
                    //         shape: BoxShape.rectangle,
                    //         color:
                    //             Colors.grey, // Grey color for the circular container
                    //       ),
                    //     ),
                    //   ),
                    Image(
                      image: isNetworkImage
                          ? NetworkImage(imageUrl) as ImageProvider
                          : AssetImage(imageUrl) as ImageProvider,
                      fit: fit,
                      width: width,
                      height: height,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image,
                              size: 40, color: Colors.grey),
                        );
                      },
                    ),
                  ],
                ),
              )
            : ClipRRect(
                borderRadius: applyImageRadius
                    ? BorderRadius.circular(borderRadius)
                    : BorderRadius.zero,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // if (isNetworkImage)
                    //   Shimmer.fromColors(
                    //     baseColor: Colors.grey[300]!,
                    //     highlightColor: Colors.grey[100]!,
                    //     child: Container(
                    //       width: double.infinity,
                    //       height: 200,
                    //       decoration: const BoxDecoration(
                    //         borderRadius: BorderRadius.all(Radius.circular(10)),
                    //         shape: BoxShape.rectangle,
                    //         color:
                    //             Colors.grey, // Grey color for the circular container
                    //       ),
                    //     ),
                    //   ),
                    Image(
                      image: isNetworkImage
                          ? NetworkImage(imageUrl) as ImageProvider
                          : AssetImage(imageUrl) as ImageProvider,
                      fit: fit,
                      width: width,
                      height: height,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image,
                              size: 40, color: Colors.grey),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
