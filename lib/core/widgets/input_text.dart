import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool validator;
  const InputText({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.validator = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: AppColors.white),
      controller: controller,
      validator: validator
          ? (value) {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(14.0),
        hintText: hintText,
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.white),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
