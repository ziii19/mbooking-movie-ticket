import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  const InputText({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.validator = true,
    this.keyboardType,
    this.inputFormatters,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: AppColors.white),
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
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
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.gray,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class InputPassword extends StatefulWidget {
  const InputPassword({super.key, this.controller});

  final TextEditingController? controller;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: passwordVisible,
      controller: widget.controller,
      style: const TextStyle(color: AppColors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(14.0),
        hintText: '*******',
        labelText: 'Password',
        labelStyle: const TextStyle(color: AppColors.white),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(
              () {
                passwordVisible = !passwordVisible;
              },
            );
          },
        ),
        alignLabelWithHint: false,
      ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    );
  }
}
