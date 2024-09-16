import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class MovieCardItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const MovieCardItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.white,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.white,
          ),
        )
      ],
    );
  }
}
