import 'dart:io';

import 'package:dartz/dartz.dart';
import '../entities/user.dart';

import '../../../../core/error/failures.dart';

abstract interface class UserRepository {
  Future<Either<Failure, User>> createUser({
    required String uid,
    required String name,
    required String email,
    num? phoneNumber,
    File? photoUrl,
  });
  Future<Either<Failure, User>> getUser(String uid);
  Future<Either<Failure, User>> updateUser({
    required String uid,
    required String name,
    required String email,
    num? phoneNumber,
    File? photoUrl,
  });
}
