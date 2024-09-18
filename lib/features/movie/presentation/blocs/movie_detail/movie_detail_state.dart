part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailState {}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailError extends MovieDetailState {
  final String error;

  MovieDetailError(this.error);
}

final class MovieDetailSuccess extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailSuccess(this.movieDetail);
}
