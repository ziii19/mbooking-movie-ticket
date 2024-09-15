import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';
import 'package:mbooking/features/auth/domain/repositories/auth_repository.dart';

class UserLogin implements Usecase<String, UserLoginParam>{
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserLoginParam params) async{
    return await authRepository.signIn(params.email, params.password);
  }
}

class UserLoginParam{
  final String email;
  final String password;
  UserLoginParam({required this.email, required this.password});
}
