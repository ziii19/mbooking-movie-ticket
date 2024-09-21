part of '../my_ticket_detail.dart';

class _MovieInfoSection extends StatelessWidget {
  const _MovieInfoSection({
    required this.movieImage,
    required this.movieTitle,
    required this.movieRuntime,
    required this.movieGenres,
  });

  final String movieImage;
  final String movieTitle;
  final int movieRuntime;
  final List<String> movieGenres;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'https://image.tmdb.org/t/p/w500$movieImage',
            width: 125,
            height: 177,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieTitle,
                  maxLines: 4,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                MovieDetailTrxItem(
                  icon: AssetsSvg.clock,
                  text: timeHHSMM(movieRuntime),
                ),
                const SizedBox(height: 4),
                MovieDetailTrxItem(
                  icon: AssetsSvg.video,
                  text: movieGenres.take(2).join(', '),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
