import 'dart:collection';

import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class TransactionsViewModel extends ChangeNotifier {
  TransactionsViewModel({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository {
    load = Command1<void, String>(_load);
  }

  final TransactionRepository _transactionRepository;

  late Command1 load;

  List<Transaction> _transactions = [];

  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_transactions);

  Future<Result<void>> _load(String clientId) async {
    try {
      final result =
          await _transactionRepository.getTransactionsList(clientId: clientId);
      switch (result) {
        case Ok():
          _transactions = result.value;
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } finally {
      notifyListeners();
    }
  }
}