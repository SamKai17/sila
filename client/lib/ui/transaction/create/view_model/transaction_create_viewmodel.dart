import 'dart:collection';
import 'package:client/data/repositories/transaction/transaction_draft_repository.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionCreateViewModel extends ChangeNotifier {
  TransactionCreateViewModel({
    required TransactionDraftRepository transactionDraftRepository,
  }) : _transactionDraftRepository = transactionDraftRepository {
    load = Command1<void, String>(_load);
  }

  late Command1 load;

  final TransactionDraftRepository _transactionDraftRepository;

  double getTotalPrice({required String clientId}) {
    return _transactionDraftRepository.getTotalPrice(clientId: clientId);
  }

  int getTotalItems({required String clientId}) {
    return _transactionDraftRepository.getTotalItems(clientId: clientId);
  }

  List<Item> _items = [];
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  Future<Result<void>> _load(String clientId) async {
    _items = _transactionDraftRepository.getItems(clientId);
    notifyListeners();
    return Result.ok(null);
  }

  void addItem({
    required String clientId,
    // required String type,
    required String name,
    required double price,
    required int quantity,
  }) {
    final String id = Uuid().v4();
    _transactionDraftRepository.addItem(
      clientId: clientId,
      item: Item(id: id, name: name, price: price, quantity: quantity),
    );
    _items = _transactionDraftRepository.getItems(clientId);
    notifyListeners();
  }

  void updateItem({
    required String id,
    required String clientId,
    required String name,
    required double price,
    required int quantity,
  }) {
    _transactionDraftRepository.updateItem(
        clientId: clientId,
        itemId: id,
        newItem: Item(id: id, name: name, price: price, quantity: quantity));
    _items = _transactionDraftRepository.getItems(clientId);
    notifyListeners();
  }

  List<Item> _selectedItems = [];

  void deleteItems(String clientId) {
    _transactionDraftRepository.deleteItems(
        items: _selectedItems, clientId: clientId);
    _items = _transactionDraftRepository.getItems(clientId);
    _selectedItems.clear();
    notifyListeners();
  }

  void addSelectedItem({required Item item}) {
    _selectedItems.add(item);
    notifyListeners();
  }

  void removeSelectedItem({required Item item}) {
    _selectedItems.remove(item);
    notifyListeners();
  }

  void clearSelectedItems() {
    _selectedItems.clear();
    notifyListeners();
  }

  bool isSelected({required Item item}) {
    return _selectedItems.contains(item);
  }

  bool get selectedMode => !_selectedItems.isEmpty;
}
