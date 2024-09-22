import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signIn(String email, String password);
  Future<Either<Failure, String>> signUp(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, String>> googleSignIn();
}
