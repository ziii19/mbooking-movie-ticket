import 'package:flutter/material.dart';
import 'package:mbooking/core/constants/assets_svg.dart';
import 'package:mbooking/core/utils/time_format.dart';

import '../../../../core/theme/app_colors.dart';
import 'movie_card_item.dart';

class UpcomingCard extends StatelessWidget {
  final String posterUrl;
  final String title;
  final String genre;
  final String release;
  const UpcomingCard({
    super.key,
    required this.posterUrl,
    required this.title,
    required this.genre,
    required this.release,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/$posterUrl',
              width: 180,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 35,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.yellow,
              ),
            ),
          ),
          const SizedBox(height: 8),
          MovieCardItem(
            icon: AssetsSvg.video,
            text: genre,
          ),
          const SizedBox(height: 4),
          MovieCardItem(
            icon: AssetsSvg.calendar,
            text: timeDDMMYYY(release),
          )
        ],
      ),
    );
  }
}
