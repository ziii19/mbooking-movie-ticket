part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class GetTransactionSuccess extends TransactionState {
  final List<Transaction> transactions;
  GetTransactionSuccess(this.transactions);
}

final class TransactionSuccess extends TransactionState {
  final Transaction transaction;
  TransactionSuccess(this.transaction);
}

final class TransactionFailed extends TransactionState {
  final String error;
  TransactionFailed(this.error);
}
