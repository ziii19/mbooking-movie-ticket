import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/transaction_model.dart';

abstract interface class TransactionRemoteDataSource {
  Future<TransactionModel> createTransaction(TransactionModel transactionModel);
  Future<List<TransactionModel>> getTransactions(String uid);
  Future<TransactionModel> updateTransaction(TransactionModel transactionModel);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  TransactionRemoteDataSourceImpl(this.firebaseFirestore);
  @override
  Future<TransactionModel> createTransaction(
      TransactionModel transactionModel) async {
    try {
      await firebaseFirestore
          .collection('transactions')
          .doc(transactionModel.trxId)
          .set(transactionModel.toMap());
      return transactionModel;
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions(String uid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('transactions')
              .where('uid', isEqualTo: uid)
              .get();
      return querySnapshot.docs
          .map((e) => TransactionModel.fromMap(e.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<TransactionModel> updateTransaction(
      TransactionModel transactionModel) async {
    try {
      await firebaseFirestore
          .collection('transactions')
          .doc(transactionModel.trxId)
          .update(transactionModel.toMap());
      return transactionModel;
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
