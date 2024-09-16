class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final String language;
  final double voteAverage;
  final int voteCount;
  final int runtime;
  final List<String> genres;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.language,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.genres,
  });
}
