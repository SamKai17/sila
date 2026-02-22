import 'dart:collection';
import 'package:client/domain/models/item/item.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionCreateViewModel extends ChangeNotifier {
  List<Item> _items = [];
  List<Item> _selectedItems = [];

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

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

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

  bool get selectedMode => !_selectedItems.isEmpty;
}
