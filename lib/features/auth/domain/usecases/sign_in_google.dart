import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';

import '../repositories/auth_repository.dart';

class SignInGoogle implements Usecase<String, NoParams> {
  final AuthRepository authRepository;

  SignInGoogle(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.googleSignIn();
  }
}
