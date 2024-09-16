import 'package:dartz/dartz.dart';

import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/features/movie/data/datasource/movie_remote_data_source.dart';

import 'package:mbooking/features/movie/domain/entities/movie.dart';

import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;

  MovieRepositoryImpl(this.movieRemoteDataSource);
  @override
  Future<Either<Failure, Movie>> getMovieDetail(int id) {
    // TODO: implement getMovieDetail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlaying(int page) async {
    try {
      final result = await movieRemoteDataSource.getNowPlaying(page);
      return Right(result);
    } on Exception catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcoming(int page) async {
    try {
      final result = await movieRemoteDataSource.getUpcoming(page);
      return Right(result);
    } on Exception catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
