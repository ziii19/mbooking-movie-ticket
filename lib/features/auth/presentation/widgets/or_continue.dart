import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OrContinue extends StatelessWidget {
  const OrContinue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.white.withOpacity(.4),
            thickness: 1,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Or continue with',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.white.withOpacity(.4),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
