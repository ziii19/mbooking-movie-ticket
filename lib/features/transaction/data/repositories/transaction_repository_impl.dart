import 'package:dartz/dartz.dart';

import 'package:mbooking/core/error/failures.dart';
import 'package:mbooking/features/transaction/data/datasource/transaction_remote_data_source.dart';

import 'package:mbooking/features/transaction/domain/transaction.dart';

import '../../domain/repositories/transaction_repository.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource transactionRemoteDataSource;

  TransactionRepositoryImpl(this.transactionRemoteDataSource);
  @override
  Future<Either<Failure, Transaction>> createTransaction(
      TransactionModel transactionModel) async {
    try {
      await transactionRemoteDataSource.createTransaction(transactionModel);
      return Right(transactionModel);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions(String uid) async {
    try {
      final transactions =
          await transactionRemoteDataSource.getTransactions(uid);
      return Right(transactions);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> updateTransaction(
      TransactionModel transactionModel) async {
    try {
      await transactionRemoteDataSource.updateTransaction(transactionModel);
      return Right(transactionModel);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
