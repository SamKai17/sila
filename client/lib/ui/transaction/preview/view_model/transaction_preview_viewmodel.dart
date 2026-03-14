import 'dart:async';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/utils/result.dart';
import 'package:riverpod/riverpod.dart';

final transactionPreviewViewModel =
    AsyncNotifierProvider<TransactionPreviewViewModel, void>(
        TransactionPreviewViewModel.new);

class TransactionPreviewViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    _transactionRepository = ref.read(transactionRepository);
  }

  late TransactionRepository _transactionRepository;

  Future<String?> addTransaction({
    required double totalPrice,
    required double paid,
    required List<Item> items,
    required String type,
    required String clientId,
  }) async {
    try {
      state = AsyncValue.loading();
      final result = await _transactionRepository.addTransaction(
        totalPrice: totalPrice,
        totalPaid: paid,
        remainder: totalPrice - paid,
        paid: paid,
        items: items,
        type: type,
        clientId: clientId,
      );
      switch (result) {
        case Ok():
          state = AsyncValue.data(null);
          return result.value;
        case Error():
          state = AsyncValue.error(result.error, StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
    return null;
  }
}