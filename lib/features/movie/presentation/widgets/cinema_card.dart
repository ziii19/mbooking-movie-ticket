import 'package:flutter/material.dart';
import 'package:mbooking/core/utils/convert_to_idr.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? AppColors.yellow9 : AppColors.enabled,
        border: isActive ? Border.all(color: AppColors.yellow) : null,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18)
                    .copyWith(top: 18),
                child: Row(
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
                    Image.asset(
                      cinema.icon,
                      width: 32,
                      height: 16,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0)
                    .copyWith(bottom: 18),
                child: Text(
                  cinema.location,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: const BoxDecoration(
                color: AppColors.yellow9,
                border: Border(
                  top: BorderSide(
                    color: AppColors.yellow,
                  ),
                  left: BorderSide(
                    color: AppColors.yellow,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                ),
              ),
              child: Text(
                convertToIdr(cinema.price, 2),
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
