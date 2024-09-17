import 'package:flutter/material.dart';
import 'package:mbooking/core/utils/number_format.dart';
import 'package:mbooking/core/utils/time_format.dart';
import 'package:mbooking/features/movie/data/datasource/movie_remote_data_source.dart';

import '../../../../core/theme/app_colors.dart';

class MovieSliderCard extends StatefulWidget {
  final int id;
  final String posterUrl;
  final String title;
  final String genre;
  final String vote;
  final String voteCount;

  const MovieSliderCard({
    super.key,
    required this.id,
    required this.posterUrl,
    required this.title,
    required this.genre,
    required this.vote,
    required this.voteCount,
  });

  @override
  State<MovieSliderCard> createState() => _MovieSliderCardState();
}

class _MovieSliderCardState extends State<MovieSliderCard> {
  String? runtime;

  @override
  void initState() {
    super.initState();
    getRuntime();
  }

  getRuntime() async {
    MovieRemoteDataSourceImpl().getMovieDetail(widget.id).then((value) {
      setState(() {
        runtime = value.runtime.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://image.tmdb.org/t/p/w500/${widget.posterUrl}',
            height: 400,
            width: 300,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.title,
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
          '${runtime != null ? timeHHMM(int.parse(runtime!)) : '-'} • ${widget.genre}',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.gray1,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: AppColors.yellow),
            const SizedBox(width: 4),
            Text(
              widget.vote,
              style: const TextStyle(fontSize: 16, color: AppColors.white),
            ),
            const SizedBox(width: 4),
            Text(
              '(${numFormat(widget.voteCount)})',
              style: const TextStyle(fontSize: 12, color: AppColors.gray),
            ),
          ],
        ),
      ],
    );
  }
}
