import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class BuildUserInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  const BuildUserInfo({
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
          size: 20,
          color: AppColors.outline,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.9,
          ),
        )
      ],
    );
  }
}
