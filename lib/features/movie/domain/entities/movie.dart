class Movie {
  final int id;
  final String title;
  final String posterPath;
  final List<int> genreIds;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.genreIds,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
  });
}
