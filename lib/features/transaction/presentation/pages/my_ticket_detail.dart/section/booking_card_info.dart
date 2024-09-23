part of '../my_ticket_detail.dart';

class _BookingCardInfo extends StatelessWidget {
  const _BookingCardInfo({
    required this.icon,
    required this.textUp,
    required this.textDown,
  });

  final String icon;
  final String textUp;
  final String textDown;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isSmall = constraints.maxWidth <= 400;
      return Row(
        children: [
          SvgPicture.asset(
            icon,
            width: isSmall ? 30 : 48,
            height: isSmall ? 30 : 48,
            colorFilter: const ColorFilter.mode(
              AppColors.black,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textUp,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: isSmall ? 14 : 16,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 100,
                child: Text(
                  textDown,
                  maxLines: 3,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: isSmall ? 14 : 16,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
