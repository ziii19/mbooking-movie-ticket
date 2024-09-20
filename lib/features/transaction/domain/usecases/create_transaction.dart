import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/core/usecases/usecases.dart';
import 'package:mbooking/features/transaction/data/models/transaction_model.dart';

import '../repositories/transaction_repository.dart';
import '../transaction.dart';

class CreateTransaction
    implements Usecase<Transaction, CreateTransactionParams> {
  final TransactionRepository transactionRepository;

  CreateTransaction(this.transactionRepository);

  @override
  Future<Either<Failure, Transaction>> call(CreateTransactionParams params) async {
    return await transactionRepository.createTransaction(
        params.transactionModel);
  }
}

class CreateTransactionParams {
  final TransactionModel transactionModel;

  CreateTransactionParams(this.transactionModel);
}
