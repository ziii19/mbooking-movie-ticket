part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailEvent {}

final class BlocGetMovieDetai extends MovieDetailEvent {
  final int id;

  BlocGetMovieDetai(this.id);
}
