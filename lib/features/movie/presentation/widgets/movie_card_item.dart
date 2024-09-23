import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';

class MovieCardItem extends StatelessWidget {
  final String icon;
  final Color? iconColor;
  final String text;
  const MovieCardItem({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          colorFilter:
              ColorFilter.mode(iconColor ?? AppColors.outline, BlendMode.srcIn),
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.white,
            ),
          ),
        )
      ],
    );
  }
}
