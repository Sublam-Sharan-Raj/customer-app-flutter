import 'package:flutter/material.dart';
import 'package:insta_closet/app_colors.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final bool labelTextEnabled;
  final double elevation;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboard;
  final FocusNode? focusNode;
  final VoidCallback? onFinished;
  final bool isPassword;
  final double horizontalPadding;
  final double verticalPadding;
  final Function(String)? onValueChanged; // Make sure this has a type
  final Color borderColor;
  final int? maxLines;
  final int? maxLength;
  final bool? readOnly;

  const CustomInputField(
      {super.key,
      required this.controller,
      this.hint,
      this.labelTextEnabled = true,
      this.elevation = 3,
      this.validator,
      this.keyboard = TextInputType.text,
      this.focusNode,
      this.onFinished,
      this.isPassword = false,
      this.horizontalPadding = 16.0,
      this.verticalPadding = 0.0,
      this.onValueChanged,
      this.borderColor = Colors.white,
      this.maxLines = 1,
      this.maxLength,
      this.readOnly = false});

  @override
  State<CustomInputField> createState() => CustomInputFieldState();
}

class CustomInputFieldState extends State<CustomInputField> {
  String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboard,
          obscureText: widget.isPassword,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly ?? false,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: AppColors.grey,
            counterText: "",
            labelText: widget.labelTextEnabled ? widget.hint : null,
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          onChanged: (value) {
            if (widget.onValueChanged != null) {
              widget.onValueChanged!(value);
            }
            setState(() {
              error = widget.validator?.call(value); // Validate on change
            });
          },
          validator: (value) {
            error = widget.validator?.call(value); // Use the validator
            return error; // Return error for TextFormField
          },
        ),
        // if (error != null)
        //   Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 5),
        //     padding: const EdgeInsets.symmetric(vertical: 2),
        //     color: AppColors.secondary,
        //     width: double.infinity,
        //     child: Text(
        //       error!,
        //       textAlign: TextAlign.center,
        //       style: const TextStyle(
        //         color: Colors.white,
        //         fontSize: 12,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
