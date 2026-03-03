import 'package:client/data/repositories/transaction/transaction_draft_repository.dart';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/transaction_draft/transaction_draft.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class TransactionPreviewViewModel extends ChangeNotifier {
  TransactionPreviewViewModel({
    required TransactionRepository transactionRepository,
    required TransactionDraftRepository transactionDraftRepository,
  })  : _transactionRepository = transactionRepository,
        _transactionDraftRepository = transactionDraftRepository {
    addTransaction = Command1<void, Map<String, String>>(_addTransaction);
    load = Command1<void, String>(_load);
  }

  final TransactionRepository _transactionRepository;
  final TransactionDraftRepository _transactionDraftRepository;

  String? transactionId;

  late Command1 addTransaction;
  late Command1 load;

  // List<Item> _items = [];
  TransactionDraft? transaction;
  // UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double getTotalPrice({required String clientId}) {
    return _transactionDraftRepository.getTotalPrice(clientId: clientId);
  }

  int getTotalItems({required String clientId}) {
    return _transactionDraftRepository.getTotalItems(clientId: clientId);
  }

  Future<Result<void>> _load(String clientId) async {
    try {
      final transactionDraftResult =
          _transactionDraftRepository.getTransactionDraft(clientId);
      switch (transactionDraftResult) {
        case Ok():
          transaction = transactionDraftResult.value;
          return Result.ok(null);
        case Error():
          return Result.error(transactionDraftResult.error);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _addTransaction(Map<String, String> values) async {
    try {
      final result = await _transactionDraftRepository.addTransaction(
          clientId: values['clientId']!, type: values['type']!);
      switch (result) {
        case Ok():
          transactionId = result.value;
          _transactionDraftRepository.clear();
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } finally {
      notifyListeners();
    }
  }
}
