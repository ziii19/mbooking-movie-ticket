import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const TitleSection({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            height: 2.2,
            color: AppColors.white,
          ),
        ),
        TextButton(
            onPressed: onPressed,
            child: const Row(
              children: [
                Text(
                  'See all',
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.yellow,
                ),
              ],
            ))
      ],
    );
  }
}
