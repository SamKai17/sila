import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class TransactionReceiptViewModel extends ChangeNotifier {
  TransactionReceiptViewModel({
    required TransactionRepository transactionRepository,
  }) : _transactionRepository = transactionRepository {
    load = Command1<void, String>(_load);
  }
  late Command1 load;

  final TransactionRepository _transactionRepository;

  Transaction? transaction;

  Future<Result<void>> _load(String transactionId) async {
    try {
      final transactionResult = await _transactionRepository.getTransaction(
          transactionId: transactionId);
      switch (transactionResult) {
        case Ok():
          transaction = transactionResult.value;
          return Result.ok(null);
        case Error():
          return Result.error(transactionResult.error);
      }
    } finally {
      notifyListeners();
    }
  }
}
