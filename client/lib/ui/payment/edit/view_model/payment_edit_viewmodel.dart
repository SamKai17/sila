import 'dart:async';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentEditViewModel = AsyncNotifierProvider(PaymentEditViewModel.new);

class PaymentEditViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    _transactionRepository = ref.read(transactionRepository);
  }

  late TransactionRepository _transactionRepository;

  Future<void> updatePayment({
    required Transaction transaction,
    required Payment payment,
    required double newAmount,
  }) async {
    await _transactionRepository.updatePayment(
        transaction: transaction, payment: payment, newAmount: newAmount);
  }
}
