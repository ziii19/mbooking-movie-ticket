part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class BlocGetMovies extends MoviesEvent {
  final int page;
  BlocGetMovies({required this.page});
}
