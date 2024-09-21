import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/features/transaction/data/models/transaction_model.dart';
import 'package:mbooking/features/transaction/domain/usecases/create_transaction.dart';
import 'package:mbooking/features/transaction/domain/usecases/get_user_transaction.dart';
import 'package:mbooking/features/transaction/domain/usecases/update_transaction.dart';

import '../../../domain/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final CreateTransaction _createTransaction;
  final UpdateTransaction _updateTransaction;
  final GetUserTransaction _getUserTransaction;
  TransactionBloc({
    required CreateTransaction createTransaction,
    required UpdateTransaction updateTransaction,
    required GetUserTransaction getUserTransaction,
  })  : _createTransaction = createTransaction,
        _updateTransaction = updateTransaction,
        _getUserTransaction = getUserTransaction,
        super(TransactionInitial()) {
    on<TransactionEvent>((_, emit) => emit(TransactionLoading()));
    on<AddTransaction>((event, emit) async {
      emit(TransactionLoading());
      final result =
          await _createTransaction(CreateTransactionParams(event.transaction));
      result.fold(
        (l) => emit(TransactionFailed(l.message)),
        (r) => emit(TransactionSuccess(r)),
      );
    });
    on<BlocUpdateTransaction>((event, emit) async {
      emit(TransactionLoading());
      final result =
          await _updateTransaction(UpdateTransactionParams(event.transaction));
      result.fold(
        (l) => emit(TransactionFailed(l.message)),
        (r) => emit(TransactionSuccess(r)),
      );
    });
    on<GetTransaction>((event, emit) async {
      emit(TransactionLoading());
      final result =
          await _getUserTransaction(GetUserTransactionParams(event.userId));
      result.fold(
        (l) => emit(TransactionFailed(l.message)),
        (r) => emit(GetTransactionSuccess(r)),
      );
    });
  }
}
