import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';

import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateUser implements Usecase<User, UpdateUserParam> {
  final UserRepository userRepository;

  UpdateUser(this.userRepository);

  @override
  Future<Either<Failure, User>> call(UpdateUserParam params) async {
    return await userRepository.updateUser(
      uid: params.uid,
      name: params.name,
      email: params.email,
      phoneNumber: params.phoneNumber,
      photoUrl: params.photoUrl,
    );
  }
}

class UpdateUserParam {
  final String uid;
  final String name;
  final String email;
  final num? phoneNumber;
  final File? photoUrl;
  UpdateUserParam({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
  });
}
