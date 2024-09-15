import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mbooking/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, String>> signIn(String email, String password) async {
    try {
      final result = await authRemoteDataSource.signIn(email, password);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final result = await authRemoteDataSource.signOut();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signUp(String email, String password) async {
    try {
      final result = await authRemoteDataSource.signUp(email, password);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
