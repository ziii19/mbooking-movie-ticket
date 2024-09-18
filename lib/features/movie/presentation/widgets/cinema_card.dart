import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/cinema.dart';
import '../../../../core/theme/app_colors.dart';

class CinemaCard extends StatelessWidget {
  final Cinema cinema;
  final bool isActive;
  const CinemaCard({
    super.key,
    required this.cinema,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? AppColors.yellow9 : AppColors.enabled,
        border: isActive ? Border.all(color: AppColors.yellow) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cinema.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              SvgPicture.asset(
                cinema.icon,
                width: 32,
                height: 16,
              ),
            ],
          ),
          Text(
            cinema.location,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
