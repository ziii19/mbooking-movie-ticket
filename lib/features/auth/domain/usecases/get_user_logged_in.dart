import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';
import 'package:mbooking/features/auth/domain/repositories/user_repository.dart';

import '../entities/user.dart';

class GetUserLoggedIn implements Usecase<User, GetUserParam> {
  final UserRepository userRepository;
  GetUserLoggedIn(this.userRepository);

  @override
  Future<Either<Failure, User>> call(GetUserParam params) async {
    return await userRepository.getUser(params.uid);
  }
}

class GetUserParam {
  final String? uid;
  GetUserParam({
    this.uid,
  });
}
