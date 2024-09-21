part of '../my_ticket_detail.dart';

class _DetailTrxInfo extends StatelessWidget {
  const _DetailTrxInfo({
    required this.price,
    required this.cinema,
    required this.location,
  });

  final int price;
  final String cinema;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              AssetsSvg.moneySend,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            Text(
              convertToIdr(price, 2),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            SvgPicture.asset(
              AssetsSvg.location,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            Text(
              cinema,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 35),
            Text(
              location,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AssetsSvg.note,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Show this QR code to the ticket counter to receive your ticket',
                maxLines: 3,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
