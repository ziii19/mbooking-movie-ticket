part of '../movie_detail_booking.dart';

class _MovieDetailSection extends StatelessWidget {
  final String genre;
  final String censorship;
  final String language;
  final String storyline;
  const _MovieDetailSection({
    required this.genre,
    required this.censorship,
    required this.language,
    required this.storyline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieInfo(title: 'Movie genre', value: genre),
        const SizedBox(height: 16),
        MovieInfo(title: 'Censorship', value: censorship),
        const SizedBox(height: 16),
        MovieInfo(title: 'Language', value: language),
        const SizedBox(height: 24),
        const TitleContentDetailMovie(
          title: 'Storyline',
        ),
        const SizedBox(height: 16),
        ExpandableText(text: storyline)
      ],
    );
  }
}
