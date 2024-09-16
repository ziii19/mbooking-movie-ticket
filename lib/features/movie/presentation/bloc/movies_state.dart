part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesSuccess extends MoviesState {
  final List<Movie> upcomingMovies;
  final List<Movie> nowPlayingMovies;
  MoviesSuccess({
    required this.upcomingMovies,
    required this.nowPlayingMovies,
  });
}

final class MoviesError extends MoviesState {
  final String message;
  MoviesError(this.message);
}
