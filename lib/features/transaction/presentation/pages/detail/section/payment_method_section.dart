part of '../transaction_detail.dart';

// ignore: unused_element
class _PaymentMethod extends StatelessWidget {
  const _PaymentMethod();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: List.generate(
              5,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                width: double.infinity,
                height: 80,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.enabled,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 86,
                      height: 48,
                      color: AppColors.gray,
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'data',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      AssetsSvg.arrowRight,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
