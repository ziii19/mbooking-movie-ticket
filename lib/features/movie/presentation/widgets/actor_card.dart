import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ActorCard extends StatelessWidget {
  final String profilePath;
  final String name;
  const ActorCard({
    super.key,
    required this.profilePath,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.enabled),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image:
                    NetworkImage('https://image.tmdb.org/t/p/w500$profilePath'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
