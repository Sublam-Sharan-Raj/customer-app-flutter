import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final double? width; // Width of the circular container
  final double? height; // Height of the circular container
  final Color background; // Background color of the circular container
  final double radius; // Radius for the circular shape
  final double padding;
  final EdgeInsets margin; // Padding inside the circular container
  final Widget?
      child; // Child widget to be placed inside the circular container

  const CircularContainer(
      {super.key,
      this.width,
      this.height,
      this.background = Colors.blue, // Default background color
      this.radius = 100.0, // Default radius
      this.padding = 8, // Default padding
      this.child,
      this.margin = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? radius * 2, // Set width or default to twice the radius
      height: height ?? radius * 2, // Set height or default to twice the radius
      decoration: BoxDecoration(
        color: background,
      ),
      margin: margin,
      padding: EdgeInsets.all(padding),
      alignment: Alignment.center, // Center the child widget
      child: child, // Add the child widget
    );
  }
}
