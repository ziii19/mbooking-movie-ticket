part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

class GetTransaction extends TransactionEvent {
  final String userId;

  GetTransaction(this.userId);
}

class AddTransaction extends TransactionEvent {
  final TransactionModel transaction;
  AddTransaction(this.transaction);
}

class BlocUpdateTransaction extends TransactionEvent {
  final TransactionModel transaction;
  BlocUpdateTransaction(this.transaction);
}
