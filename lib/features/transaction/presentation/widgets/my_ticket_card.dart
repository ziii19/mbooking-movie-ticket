import 'package:flutter/material.dart';

import '../../../../core/constants/assets_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../movie/presentation/widgets/movie_card_item.dart';

class MyTicketCard extends StatelessWidget {
  final String movieImage;
  final String movieName;
  final String watchingTimes;
  final String cinema;
  final String trxStatus;
  const MyTicketCard({
    super.key,
    required this.movieImage,
    required this.movieName,
    required this.watchingTimes,
    required this.cinema,
    required this.trxStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.enabled),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500$movieImage',
                  width: 100,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0)
                      .copyWith(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MovieCardItem(icon: AssetsSvg.clock, text: watchingTimes),
                      const SizedBox(height: 4),
                      MovieCardItem(icon: AssetsSvg.clock, text: cinema),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  margin: const EdgeInsets.only(top: 8, right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: trxStatus == 'Success'
                        ? Colors.green.shade900.withOpacity(.3)
                        : trxStatus == 'Pending'
                            ? Colors.yellow.shade900.withOpacity(.3)
                            : Colors.red.shade900.withOpacity(.5),
                  ),
                  child: Text(trxStatus,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
