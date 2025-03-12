import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String image; // Path to the image
  final String title; // Title of the category
  final VoidCallback onClick; // Click action

  const Category({
    super.key,
    required this.image,
    required this.title,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = Uri.tryParse(image)?.hasAbsolutePath ?? false;
    return GestureDetector(
      onTap: onClick, // Trigger the click action
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: isNetworkImage
                    ? NetworkImage(image) as ImageProvider
                    : AssetImage(image) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
