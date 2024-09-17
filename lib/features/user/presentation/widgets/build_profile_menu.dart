import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';

class BuildProfileMenu extends StatelessWidget {
  final String icon;
  final String text;
  final void Function()? onTap;
  const BuildProfileMenu({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: AppColors.gray,
          ),
        )),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 24,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
