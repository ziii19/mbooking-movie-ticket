part of '../my_ticket_detail.dart';

class _DashedLine extends StatelessWidget {
  const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  children: List.generate(
                    (constraints.constrainWidth() / 15).floor(),
                    (index) => Expanded(
                      child: Container(
                        width: 5,
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: -24,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -24,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
