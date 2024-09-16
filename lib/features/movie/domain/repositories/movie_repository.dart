import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/movie.dart';

abstract interface class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlaying(int page);
  Future<Either<Failure, List<Movie>>> getUpcoming(int page);
  Future<Either<Failure, Movie>> getMovieDetail(int id);
}
