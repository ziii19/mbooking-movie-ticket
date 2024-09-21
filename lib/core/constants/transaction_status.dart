enum TransactionStatus { pending, success, failed }

extension TransactionStatusExtension on TransactionStatus {
  String get statusName {
    switch (this) {
      case TransactionStatus.success:
        return 'Success';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.pending:
        return 'Pending';
    }
  }
}
