part of '../my_ticket_detail.dart';

class _BarCodeSection extends StatelessWidget {
  const _BarCodeSection({required this.trxId});

  final String trxId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: Column(
        children: [
          BarcodeWidget(
            data: trxId,
            barcode: Barcode.code128(),
            height: 100,
            drawText: false,
          ),
          const SizedBox(height: 8),
          Text(
            'Order ID: $trxId',
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
