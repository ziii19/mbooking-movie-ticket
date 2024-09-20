part of '../transaction_detail.dart';

class _MovieSection extends StatelessWidget {
  const _MovieSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.enabled,
          ),
          child: Row(
            children: [
              Image.network(
                'https://image.tmdb.org/t/p/w500${state.movieImage}',
                width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 19).copyWith(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.movieTitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        height: 1.8,
                        color: AppColors.yellow,
                      ),
                    ),
                    MovieCardItem(
                        icon: AssetsSvg.videoPlay,
                        text: state.movieGenres!
                            .take(2)
                            .map(
                              (e) => e,
                            )
                            .join(', ')),
                    const SizedBox(height: 10),
                    MovieCardItem(
                        icon: AssetsSvg.location, text: state.cinema!),
                    const SizedBox(height: 10),
                    MovieCardItem(
                        icon: AssetsSvg.clock,
                        text:
                            '${timeDDMMYYY(MovieBookingProperti.dates[state.wathcingDate!].toString())} . ${MovieBookingProperti.times[state.wathcingTime!]}'),
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
