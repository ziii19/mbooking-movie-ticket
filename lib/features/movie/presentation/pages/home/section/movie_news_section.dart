part of '../home_page.dart';

class _MovieNewsSection extends StatelessWidget {
  const _MovieNewsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(
          title: 'Movie news',
          onPressed: () {},
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              8,
              (index) => Container(
                width: 240,
                margin: EdgeInsets.only(right: index == 7 ? 0 : 20),
                child: Column(
                  children: [
                    Container(
                      width: 240,
                      height: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.gray,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Commodi, incidunt.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        height: 1.8,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
