import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/features/movie/domain/usecases/get_now_playing.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_upcoming.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlaying _getNowPlaying;
  final GetUpcoming _getUpcoming;
  MoviesBloc({
    required GetNowPlaying getNowPlaying,
    required GetUpcoming getUpcoming,
  })  : _getNowPlaying = getNowPlaying,
        _getUpcoming = getUpcoming,
        super(MoviesInitial()) {
    on<MoviesEvent>((_, emit) => emit(MoviesLoading()));

    on<BlocGetMovies>((event, emit) async {
      final nowPlaying = await _getNowPlaying(GetNowPlayingParam(event.page));
      final upcoming = await _getUpcoming(GetUpcomingParam(event.page));

      nowPlaying.fold((l) => emit(MoviesError(l.message)), (nowPlaying) {
        upcoming.fold((l) => emit(MoviesError(l.message)), (upComing) {
          emit(MoviesSuccess(
            nowPlayingMovies: nowPlaying,
            upcomingMovies: upComing,
          ));
        });
      });
    });
  }
}
