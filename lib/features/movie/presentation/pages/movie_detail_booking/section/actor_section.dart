part of '../movie_detail_booking.dart';

class _ActorSection extends StatelessWidget {
  final List<Actor> actors;
  const _ActorSection({required this.actors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleContentDetailMovie(title: 'Director'),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: actors
                .where((element) => element.job == 'Director')
                .map(
                  (e) => Padding(
                    padding:
                        EdgeInsets.only(right: e.id == actors.last.id ? 0 : 16),
                    child: ActorCard(name: e.name, profilePath: e.profilePath),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
        const TitleContentDetailMovie(title: 'Actor'),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: actors
                .where((element) => element.job != 'Director')
                .map(
                  (e) => Padding(
                    padding:
                        EdgeInsets.only(right: e.id == actors.last.id ? 0 : 16),
                    child: ActorCard(name: e.name, profilePath: e.profilePath),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
