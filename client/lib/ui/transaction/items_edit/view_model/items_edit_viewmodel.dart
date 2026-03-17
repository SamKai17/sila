import 'dart:async';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemsEditViewModel = NotifierProvider.autoDispose
    .family<TransactionCreateViewModel, List<Item>, List<Item>>(
        TransactionCreateViewModel.new);

final updateItems = AsyncNotifierProvider(UpdateItems.new);

class UpdateItems extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    _transactionRepository = ref.read(transactionRepository);
  }

  late TransactionRepository _transactionRepository;

  List<Item> _itemsToDelete(
      {required List<Item> oldItems, required List<Item> newItems}) {
    final result = oldItems.where((item) => !newItems.contains(item)).toList();
    print(result);
    return result;
  }

  Future<void> updateItems({
    required List<Item> newItems,
    required List<Item> oldItems,
    required Transaction transaction,
  }) async {
    await _transactionRepository.updateItems(
      itemsToAdd: newItems,
      itemsToDelete: _itemsToDelete(oldItems: oldItems, newItems: newItems),
      transaction: transaction,
    );
  }
}