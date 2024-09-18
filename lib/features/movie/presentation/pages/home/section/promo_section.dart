part of '../home_page.dart';

class _PromoSection extends StatelessWidget {
  const _PromoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(title: 'Promo  & Discount', onPressed: () {}),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              3,
              (index) => Container(
                margin: EdgeInsets.only(right: index == 2 ? 0 : 16),
                width: 360,
                height: 225,
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
