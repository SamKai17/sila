import 'dart:async';
import 'dart:collection';
import 'package:client/data/repositories/transaction/transaction_draft_repository.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

final itemsTotalPrice = Provider<double>(
  (ref) {
    final items = ref.watch(transactionCreateViewModel);
    double total = 0.0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  },
);

final transactionCreateViewModel =
    NotifierProvider<TransactionCreateViewModel, List<Item>>(
        TransactionCreateViewModel.new);

class TransactionCreateViewModel extends Notifier<List<Item>> {
  @override
  List<Item> build() {
    return [];
  }

  void addItem({
    required String name,
    required double price,
    required int quantity,
  }) {
    final String id = Uuid().v4();
    final newItem = Item(id: id, name: name, price: price, quantity: quantity);
    state = [...state, newItem];
  }

  void updateItem({
    required String id,
    required String name,
    required double price,
    required int quantity,
  }) {
    final oldItem = state.firstWhere((item) => item.id == id);
    final newItem =
        oldItem.copyWith(name: name, price: price, quantity: quantity);
    final newList = state.map(
      (item) {
        if (item.id == id) {
          return newItem;
        }
        return item;
      },
    ).toList();
    state = newList;
  }

  void deleteItems() {
    final toRemoveItems = ref.read(selectedItems);
    state = state.where((item) => !toRemoveItems.contains(item)).toList();
  }
}

final isItemSelected = Provider.family(
  (ref, Item item) {
    final _selectedClients = ref.watch(selectedItems);
    return _selectedClients.contains(item);
  },
);

final isItemSelectedMode = Provider(
  (ref) {
    final _selectedClients = ref.watch(selectedItems);
    return _selectedClients.isNotEmpty;
  },
);

final selectedItems =
    NotifierProvider<SelectedItems, List<Item>>(SelectedItems.new);

class SelectedItems extends Notifier<List<Item>> {
  @override
  List<Item> build() {
    return [];
  }

  void addSelectedItem(Item item) {
    state = [...state, item];
  }

  void removeSelectedItem(Item item) {
    final newList = [...state];
    newList.remove(item);
    state = newList;
  }

  void clearSelectedItems() {
    state = [];
  }
}