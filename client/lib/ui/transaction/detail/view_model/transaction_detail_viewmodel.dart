import 'dart:async';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionDetailViewModel = AsyncNotifierProvider.autoDispose
    .family<TransactionDetailViewModel, Transaction, String>(
        TransactionDetailViewModel.new);

class TransactionDetailViewModel extends AsyncNotifier<Transaction> {
  TransactionDetailViewModel(this.transactionId);
  final String transactionId;
  @override
  FutureOr<Transaction> build() {
    _transactionRepository = ref.read(transactionRepository);
    return load(transactionId);
  }

  late TransactionRepository _transactionRepository;

  Future<Transaction> load(String transactionId) async {
    try {
      final result = await _transactionRepository.getTransaction(
          transactionId: transactionId);
      switch (result) {
        case Ok():
          return result.value;
        case Error():
          throw result.error;
      }
    } catch (e) {
      rethrow;
    }
  }
}
