import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';

import '../entities/user.dart';
import '../repositories/user_repository.dart';

class CreateUser implements Usecase<User, CreateUserParam> {
  final UserRepository userRepository;
  CreateUser(this.userRepository);

  @override
  Future<Either<Failure, User>> call(CreateUserParam params) async {
    return await userRepository.createUser(
      uid: params.uid,
      name: params.name,
      email: params.email,
      phoneNumber: params.phoneNumber,
      photoUrl: params.photoUrl,
    );
  }
}

class CreateUserParam {
  final String uid;
  final String name;
  final String email;
  final num? phoneNumber;
  final File? photoUrl;
  CreateUserParam({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
  });
}
