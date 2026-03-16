import 'dart:async';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentPreviewViewModel =
    AsyncNotifierProvider<PaymentPreviewViewModel, void>(
        PaymentPreviewViewModel.new);

class PaymentPreviewViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    _transactionRepository = ref.read(transactionRepository);
    throw UnimplementedError();
  }

  late TransactionRepository _transactionRepository;

  Future<void> addPayment({
    required double paid,
    required Transaction transaction,
  }) async {
    try {
      state = AsyncValue.loading();
      final result = await _transactionRepository.addPayment(
        amount: paid,
        transaction: transaction,
      );
      switch (result) {
        case Ok():
          state = AsyncValue.data(null);
        case Error():
          state = AsyncValue.error(result.error, StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
