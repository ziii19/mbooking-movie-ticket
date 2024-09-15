import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/features/auth/data/datasources/user_repo_remote_data_source.dart';
import 'package:mbooking/features/auth/data/models/user_model.dart';

import 'package:mbooking/features/auth/domain/entities/user.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRepoRemoteDataSource userRepoRemoteDataSource;
  UserRepositoryImpl(this.userRepoRemoteDataSource);

  @override
  Future<Either<Failure, User>> createUser({
    required String uid,
    required String name,
    required String email,
    num? phoneNumber,
    File? photoUrl,
  }) async {
    try {
      UserModel userModel = UserModel(
        uid: uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        photoUrl: null,
      );

      if (photoUrl != null) {
        final imageUrl = await userRepoRemoteDataSource.uploadImage(
          user: userModel,
          image: File(photoUrl.path),
        );
        userModel = userModel.copyWith(photoUrl: imageUrl);
      }

      final user = await userRepoRemoteDataSource.createUser(userModel);

      return Right(user);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUser(String uid) async {
    try {
      UserModel userModel = await userRepoRemoteDataSource.getUser(uid);
      return Right(userModel);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser({
    required String uid,
    required String name,
    required String email,
    num? phoneNumber,
    File? photoUrl,
  }) async {
    try {
      UserModel userModel = UserModel(
        uid: uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        photoUrl: null,
      );
      if (photoUrl != null) {
        final imageUrl = await userRepoRemoteDataSource.uploadImage(
          user: userModel,
          image: File(photoUrl.path),
        );
        userModel = userModel.copyWith(photoUrl: imageUrl);
      }

      final user = await userRepoRemoteDataSource.updateUser(userModel);

      return Right(user);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
