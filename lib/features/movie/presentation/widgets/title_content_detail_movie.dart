import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class TitleContentDetailMovie extends StatelessWidget {
  final String title;
  const TitleContentDetailMovie({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
    );
  }
}
