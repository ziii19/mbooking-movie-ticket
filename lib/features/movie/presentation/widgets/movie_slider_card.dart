import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class MovieSliderCard extends StatelessWidget {
  final String posterUrl;
  final String title;
  final String runtime;
  final String genre;
  final String vote;
  final String voteCount;

  const MovieSliderCard({
    super.key,
    required this.posterUrl,
    required this.title,
    required this.runtime,
    required this.genre,
    required this.vote,
    required this.voteCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://image.tmdb.org/t/p/w500/$posterUrl',
            height: 400,
            width: 300,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          '$runtime · $genre',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: AppColors.yellow),
            const SizedBox(width: 4),
            Text(
              vote,
              style: const TextStyle(fontSize: 16, color: AppColors.white),
            ),
            const SizedBox(width: 4),
            Text(
              voteCount,
              style: const TextStyle(fontSize: 12, color: AppColors.gray),
            ),
          ],
        ),
      ],
    );
  }
}
