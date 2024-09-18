part of '../movie_detail_booking.dart';

class _PickCinema extends StatelessWidget {
  final List<Cinema> listCinema;
  final int? selectedIndex;
  final ValueChanged<int> onItemTapped;
  const _PickCinema({
    required this.listCinema,
    this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleContentDetailMovie(title: 'Cinema'),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 96 * 3,
          child: Column(
              children: listCinema.map(
            (e) {
              int index = listCinema.indexOf(e);
              return GestureDetector(
                onTap: () => onItemTapped(index),
                child: CinemaCard(
                  cinema: e,
                  isActive: selectedIndex == index,
                ),
              );
            },
          ).toList()),
        ),
      ],
    );
  }
}
