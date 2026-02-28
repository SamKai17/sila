import 'dart:collection';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionCreateViewModel extends ChangeNotifier {
  TransactionCreateViewModel(
      {required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository {
    addTransaction = Command1<void, String>(_addTransaction);
    load = Command1<void, String>(_load);
    loadTransaction = Command1<void, String>(_loadTransaction);
  }

  late Command1 addTransaction;
  late Command1 load;
  late Command1 loadTransaction;

  final TransactionRepository _transactionRepository;

  List<Item> _selectedItems = [];

  Transaction? transaction;
  String? transactionType;

  set paid(double paid) {
    _paid = paid;
  }

  double _paid = 0.0;
  double get paid => _paid;

  bool get selectedMode => !_selectedItems.isEmpty;

  int get totalItems {
    int total = 0;
    for (var item in _items) {
      total += item.quantity;
    }
    return total;
  }

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  double get remainder {
    return totalPrice - _paid;
  }

  double get totalPaid {
    final payments = transaction?.payments;
    double result = 0;
    if (payments != null) {
      payments.forEach(
        (payment) {
          result += payment.amount;
        },
      );
    }
    return result;
  }

  List<Item> _items = [];
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  List<Transaction> _transactions = [];
  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_transactions);

  void addItem({
    required String name,
    required double price,
    required int quantity,
  }) {
    final String id = Uuid().v4();
    _items.add(Item(id: id, name: name, price: price, quantity: quantity));
    notifyListeners();
  }

  void updateItem({
    required String id,
    required String name,
    required double price,
    required int quantity,
  }) {
    final int index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index] =
          Item(id: id, name: name, price: price, quantity: quantity);
      notifyListeners();
    }
  }

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

  Future<Result<void>> _loadTransaction(String transactionId) async {
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

  Future<Result<void>> _addTransaction(String clientId) async {
    try {
      final result = await _transactionRepository.addTransaction(
        clientId: clientId,
        totalPrice: totalPrice,
        totalPaid: _paid,
        remainder: remainder,
        paid: _paid,
        type: transactionType!,
        items: _items,
      );
      switch (result) {
        case Ok():
          // reset values
          _paid = 0;
          _items.clear();
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } finally {
      notifyListeners();
    }
  }

  void addSelectedItem({required Item item}) {
    _selectedItems.add(item);
    notifyListeners();
  }

  void removeSelectedItem({required Item item}) {
    _selectedItems.remove(item);
    notifyListeners();
  }

  void deleteSelectedItems() {
    // _selectedItems.remove(item);
    _items = _items.where((item) => !_selectedItems.contains(item)).toList();
    _selectedItems.clear();
    notifyListeners();
  }

  void clearSelectedItems() {
    _selectedItems.clear();
    notifyListeners();
  }

  bool isSelected({required Item item}) {
    return _selectedItems.contains(item);
  }
}
