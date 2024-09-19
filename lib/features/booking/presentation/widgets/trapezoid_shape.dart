import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class TrapezoidShape extends StatelessWidget {
  const TrapezoidShape({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TrapezoidClipper(),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          border:
              const Border(top: BorderSide(color: AppColors.yellow, width: 3)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.yellow.withOpacity(.7),
              Colors.black.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}

class TrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(40, 0);
    path.lineTo(size.width - 40, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
