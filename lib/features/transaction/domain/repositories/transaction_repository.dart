import 'package:dartz/dartz.dart';
import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/features/transaction/data/models/transaction_model.dart';
import 'package:mbooking/features/transaction/domain/transaction.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, Transaction>> createTransaction(
      TransactionModel transactionModel);
  Future<Either<Failure, List<Transaction>>> getTransactions(String uid);
  Future<Either<Failure, Transaction>> updateTransaction(
      TransactionModel transactionModel);
}
