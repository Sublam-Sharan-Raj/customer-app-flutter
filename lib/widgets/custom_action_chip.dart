import 'package:flutter/material.dart';

class CustomActionChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color labelColor;
  final ValueChanged<String> onLabelPressed;

  const CustomActionChip({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.labelColor = Colors.black,
    required this.onLabelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ActionChip(
        side: const BorderSide(width: 0),
        label: Text(
          label,
          style: TextStyle(color: labelColor),
        ),
        backgroundColor: backgroundColor,
        onPressed: () => onLabelPressed(label),
      ),
    );
  }
}
