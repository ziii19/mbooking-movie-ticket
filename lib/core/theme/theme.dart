import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.black,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: AppColors.white, width: 1),
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    ),
  );
}
