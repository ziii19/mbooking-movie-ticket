import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/features/movie/domain/usecases/get_movie_detail.dart';

import '../../../domain/entities/movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  MovieDetailBloc({
    required GetMovieDetail getMovieDetail,
  })  : _getMovieDetail = getMovieDetail,
        super(MovieDetailInitial()) {
    on<MovieDetailEvent>((_, emit) => emit(MovieDetailLoading()));

    on<BlocGetMovieDetai>(
      (event, emit) async {
        emit(MovieDetailLoading());
        final result = await _getMovieDetail(
          GetMovieDetailParam(event.id),
        );
        result.fold(
          (l) => emit(MovieDetailError(l.message)),
          (r) => emit(MovieDetailSuccess(r)),
        );
      },
    );
  }
}
