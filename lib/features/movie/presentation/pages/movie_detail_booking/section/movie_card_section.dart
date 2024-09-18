part of '../movie_detail_booking.dart';

class _MovieCard extends StatelessWidget {
  final String title;
  final int runtime;
  final String date;
  final double vote;
  final int voteCount;
  const _MovieCard({
    required this.title,
    required this.runtime,
    required this.date,
    required this.vote,
    required this.voteCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      // height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.enabled,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppColors.white,
              height: 2,
            ),
          ),
          Text(
            '${timeHHMM(runtime)} • ${timeDDMMYYY(date)}',
            style: const TextStyle(
              color: AppColors.gray1,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Text(
                'Review',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                AssetsSvg.star,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.yellow,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                vote.toStringAsFixed(1),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
              Text(
                ' (${numFormat(voteCount)})',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.gray1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: SvgPicture.asset(
                        AssetsSvg.star,
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 122,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.gray1),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow_rounded,
                        size: 16,
                        color: AppColors.gray1,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Watch trailer',
                        style: TextStyle(
                          color: AppColors.gray1,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
