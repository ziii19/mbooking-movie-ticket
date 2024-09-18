import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/features/movie/domain/entities/actor.dart';
import 'package:mbooking/features/movie/domain/usecases/get_movie_actor.dart';
import 'package:mbooking/features/movie/domain/usecases/get_movie_detail.dart';

import '../../../domain/entities/movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieActor _getMovieActor;
  MovieDetailBloc({
    required GetMovieDetail getMovieDetail,
    required GetMovieActor getMovieActor,
  })  : _getMovieDetail = getMovieDetail,
        _getMovieActor = getMovieActor,
        super(MovieDetailInitial()) {
    on<MovieDetailEvent>((_, emit) => emit(MovieDetailLoading()));

    on<BlocGetMovieDetai>(
      (event, emit) async {
        final result = await _getMovieDetail(
          GetMovieDetailParam(event.id),
        );

        final actor = await _getMovieActor(GetMovieActorParam(event.id));

        result.fold(
          (l) => emit(MovieDetailError(l.message)),
          (movie) {
            actor.fold(
              (err) => emit(MovieDetailError(err.message)),
              (actor) => emit(MovieDetailSuccess(movie, actor)),
            );
          },
        );
      },
    );
  }
}
