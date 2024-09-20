import 'package:flutter/material.dart';
import 'package:mbooking/core/theme/app_colors.dart';

class BackNav extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final bool isBgIcon;
  const BackNav({
    super.key,
    this.onTap,
    required this.text,
    this.isBgIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isBgIcon ? AppColors.enabled : Colors.transparent,
              ),
              child: const Icon(
                Icons.arrow_back_outlined,
                color: AppColors.white,
                size: 30,
              ),
            ),
          ),
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.white),
          ),
          const SizedBox(
            width: 30,
            height: 10,
          ),
        ],
      ),
    );
  }
}
