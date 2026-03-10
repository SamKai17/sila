import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class PaymentPreviewViewModel extends ChangeNotifier {
  PaymentPreviewViewModel({
    required TransactionRepository transactionRepository,
  }) : _transactionRepository = transactionRepository {
    addPayment = Command1<void, Map<String, Object>>(_addPayment);
  }

  final TransactionRepository _transactionRepository;
  late Command1 addPayment;
  Future<Result<void>> _addPayment(Map<String, Object> values) async {
    try {
      final result = await _transactionRepository.addPayment(
          amount: values['amount'] as double,
          transaction: values['transaction'] as Transaction);
      switch (result) {
        case Ok():
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } finally {
      notifyListeners();
    }
  }
}
