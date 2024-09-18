import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';
import 'package:mbooking/features/movie/domain/repositories/movie_repository.dart';

import '../entities/actor.dart';

class GetMovieActor implements Usecase<List<Actor>, GetMovieActorParam> {
  final MovieRepository movieRepository;

  GetMovieActor(this.movieRepository);

  @override
  Future<Either<Failure, List<Actor>>> call(GetMovieActorParam params) async {
    return await movieRepository.getActorMovie(params.id);
  }
}

class GetMovieActorParam {
  final int id;

  GetMovieActorParam(this.id);
}
