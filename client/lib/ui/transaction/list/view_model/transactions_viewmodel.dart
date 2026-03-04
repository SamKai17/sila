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

  List<Transaction> _selectedTransactions = [];

  Future<void> deleteTransactions(String clientId) async {
    // you should probably load the items again instead of doing it yourself
    // _transactions = _selectedTransactions
    //     .where((transaction) => !_selectedTransactions.contains(transaction))
    //     .toList();
    List<String> transactionIds =
        _selectedTransactions.map((e) => e.id).toList();
    _transactionRepository.deleteTransactions(transactionsIds: transactionIds);
    _selectedTransactions.clear();
    _load(clientId);
    // notifyListeners();
  }

  void addSelectedTransaction({required Transaction transaction}) {
    _selectedTransactions.add(transaction);
    notifyListeners();
  }

  void removeSelectedTransaction({required Transaction transaction}) {
    _selectedTransactions.remove(transaction);
    notifyListeners();
  }

  void clearSelectedTransactions() {
    _selectedTransactions.clear();
    notifyListeners();
  }

  bool isSelected({required Transaction transaction}) {
    return _selectedTransactions.contains(transaction);
  }

  bool get selectedMode => !_selectedTransactions.isEmpty;
}
