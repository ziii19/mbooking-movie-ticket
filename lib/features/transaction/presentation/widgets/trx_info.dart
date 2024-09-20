import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class TrxInfo extends StatelessWidget {
  final String title;
  final String value;
  final bool isValueBig;
  const TrxInfo(
      {super.key,
      required this.title,
      required this.value,
      this.isValueBig = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: isValueBig ? 24 : 16,
            color: isValueBig ? AppColors.yellow : AppColors.white,
          ),
        ),
      ],
    );
  }
}
