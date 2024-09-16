import 'dart:convert';

import 'package:mbooking/features/movie/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.genreIds,
    required super.voteAverage,
    required super.voteCount,
    required super.releaseDate,
  });

  factory MovieModel.fromMap(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      genreIds: List<int>.from(json['genre_ids']),
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      releaseDate: json['release_date'],
    );
  }

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
