import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';

import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail implements Usecase<MovieDetail, GetMovieDetailParam> {
  final MovieRepository movieRepository;

  GetMovieDetail(this.movieRepository);

  @override
  Future<Either<Failure, MovieDetail>> call(GetMovieDetailParam params) async {
    return await movieRepository.getMovieDetail(params.id);
  }
}

class GetMovieDetailParam {
  final int id;

  GetMovieDetailParam(this.id);
}
