import 'package:dartz/dartz.dart';

import 'package:mbooking/core/error/failures.dart';

import '../../../../core/usecases/usecases.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetUpcoming implements Usecase<List<Movie>, GetUpcomingParam> {
  final MovieRepository movieRepository;
  GetUpcoming(this.movieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(GetUpcomingParam params) async {
    return await movieRepository.getUpcoming(params.page);
  }
}

class GetUpcomingParam {
  final int page;
  GetUpcomingParam(this.page);
}
