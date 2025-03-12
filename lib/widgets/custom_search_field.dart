import 'package:flutter/material.dart';
import 'package:insta_closet/screens/search_screen.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomSearchField({
    super.key,
    required this.controller,
    this.hintText = 'Search...',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          border: Border.all(color: Colors.grey.shade400), // Border color
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0), // Padding for icon
              child: Icon(
                Icons.search,
                color: Colors.grey.shade600, // Icon color
              ),
            ),
            Text(
              "Search",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
        // child: TextField(
        //   controller: controller,
        //   decoration: InputDecoration(
        //     hintText: hintText,
        //     hintStyle:
        //         TextStyle(color: Colors.grey.shade600), // Hint text style
        //     border: InputBorder.none, // No border
        //     prefixIcon: Padding(
        //       padding: const EdgeInsets.all(12.0), // Padding for icon
        //       child: Icon(
        //         Icons.search,
        //         color: Colors.grey.shade600, // Icon color
        //       ),
        //     ),
        //     contentPadding:
        //         const EdgeInsets.symmetric(vertical: 12.0), // Vertical padding
        //   ),
        // ),
      ),
    );
  }
}
