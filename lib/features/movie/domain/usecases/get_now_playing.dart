import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetNowPlaying implements Usecase<List<Movie>, GetNowPlayingParam> {
  final MovieRepository movieRepository;
  GetNowPlaying(this.movieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(GetNowPlayingParam params) async {
    return await movieRepository.getNowPlaying(params.page);
  }
}

class GetNowPlayingParam {
  final int page;
  GetNowPlayingParam(this.page);
}
