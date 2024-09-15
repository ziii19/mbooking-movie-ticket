import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class BottomAuthText extends StatelessWidget {
  const BottomAuthText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'By sign in or sign up, you agree to our Terms of Service\nand Privacy Policy',
        style: TextStyle(
          color: AppColors.gray,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.8,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
