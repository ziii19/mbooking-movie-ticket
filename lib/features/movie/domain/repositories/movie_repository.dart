import 'package:dartz/dartz.dart';
import 'package:mbooking/features/movie/domain/entities/actor.dart';
import 'package:mbooking/features/movie/domain/entities/movie_detail.dart';

import '../../../../core/error/failures.dart';
import '../entities/movie.dart';

abstract interface class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlaying(int page);
  Future<Either<Failure, List<Movie>>> getUpcoming(int page);
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Actor>>> getActorMovie(int id);
}
