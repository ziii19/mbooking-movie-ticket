import 'package:dartz/dartz.dart';

import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/usecases/usecases.dart';

class UserSignUp implements Usecase<String, UserSignUpParam> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignUpParam params) async {
    return await authRepository.signUp(params.email, params.password);
  }
}

class UserSignUpParam {
  final String email;
  final String password;
  UserSignUpParam({
    required this.email,
    required this.password,
  });
}
