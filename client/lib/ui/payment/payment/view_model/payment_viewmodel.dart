import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class PaymentViewModel extends ChangeNotifier {
  PaymentViewModel({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository {
    load = Command1<void, String>(_load);
  }
  late Command1 load;
  Transaction? transaction;

  final TransactionRepository _transactionRepository;

  Future<Result<void>> _load(String transactionId) async {
    try {
      final result = await _transactionRepository.getTransaction(
          transactionId: transactionId);
      switch (result) {
        case Ok():
          transaction = result.value;
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } finally {
      notifyListeners();
    }
  }
}
