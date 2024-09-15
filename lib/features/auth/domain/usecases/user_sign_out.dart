import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';

import '../repositories/auth_repository.dart';

class UserSignOut implements Usecase<void, NoParams> {
  final AuthRepository repository;
  UserSignOut(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
