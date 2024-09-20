import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';

import '../repositories/transaction_repository.dart';
import '../transaction.dart';

class GetUserTransaction
    implements Usecase<List<Transaction>, GetUserTransactionParams> {
  final TransactionRepository transactionRepository;

  GetUserTransaction(this.transactionRepository);
  @override
  Future<Either<Failure, List<Transaction>>> call(
      GetUserTransactionParams params) async {
    return await transactionRepository.getTransactions(params.uid);
  }
}

class GetUserTransactionParams {
  final String uid;

  GetUserTransactionParams(this.uid);
}
