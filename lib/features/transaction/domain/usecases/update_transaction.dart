import 'package:dartz/dartz.dart';

import 'package:mbooking/core/error/failures.dart';

import '../../../../core/usecases/usecases.dart';
import '../../data/models/transaction_model.dart';
import '../repositories/transaction_repository.dart';
import '../transaction.dart';

class UpdateTransaction
    implements Usecase<Transaction, UpdateTransactionParams> {
  final TransactionRepository transactionRepository;

  UpdateTransaction(this.transactionRepository);
  @override
  Future<Either<Failure, Transaction>> call(
      UpdateTransactionParams params) async {
    return await transactionRepository
        .updateTransaction(params.transactionModel);
  }
}

class UpdateTransactionParams {
  final TransactionModel transactionModel;

  UpdateTransactionParams(this.transactionModel);
}
