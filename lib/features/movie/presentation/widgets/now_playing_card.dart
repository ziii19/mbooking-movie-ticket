import 'package:flutter/material.dart';
import 'package:mbooking/core/constants/assets_svg.dart';
import 'package:mbooking/core/utils/time_format.dart';
import 'package:mbooking/features/movie/data/datasource/movie_remote_data_source.dart';

import '../../../../core/theme/app_colors.dart';
import '../pages/movie_detail_booking/movie_detail_booking.dart';
import 'movie_card_item.dart';

class NowPlayingCard extends StatefulWidget {
  final int id;
  final String posterUrl;
  final String vote;
  final String voteCount;
  final String title;
  final List<String> genre;
  final String release;
  const NowPlayingCard({
    super.key,
    required this.posterUrl,
    required this.title,
    required this.genre,
    required this.release,
    required this.id,
    required this.vote,
    required this.voteCount,
  });

  @override
  State<NowPlayingCard> createState() => _NowPlayingCardState();
}

class _NowPlayingCardState extends State<NowPlayingCard> {
  int? runtime;

  @override
  void initState() {
    super.initState();
    MovieRemoteDataSourceImpl().getMovieDetail(widget.id).then((value) {
      setState(() {
        runtime = value.runtime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MovieDetailBooking.route(widget.id),
      ),
      child: SizedBox(
        width: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${widget.posterUrl}',
                width: 180,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 35,
              child: Text(
                widget.title,
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
              icon: AssetsSvg.star,
              iconColor: AppColors.yellow,
              text: '${widget.vote} (${widget.voteCount})',
            ),
            const SizedBox(height: 4),
            MovieCardItem(
              icon: AssetsSvg.clock,
              text: runtime != null ? timeHHSMM(runtime!) : '-',
            ),
            const SizedBox(height: 4),
            MovieCardItem(
              icon: AssetsSvg.video,
              text: widget.genre.take(2).map((e) => e).toList().join(', '),
            ),
          ],
        ),
      ),
    );
  }
}
