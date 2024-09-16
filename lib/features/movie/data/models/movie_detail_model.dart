import '../../domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  MovieDetailModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.backdropPath,
    required super.releaseDate,
    required super.language,
    required super.voteAverage,
    required super.voteCount,
    required super.runtime,
    required super.genres,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      language: json['original_language'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      runtime: json['runtime'],
      genres: List<String>.from(json['genres'].map((genre) => genre['name'])),
    );
  }
}
