import 'dart:async';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionDetailViewModel =
    AsyncNotifierProvider<TransactionDetailViewModel, void>(
        TransactionDetailViewModel.new);

class TransactionDetailViewModel extends AsyncNotifier<void> {
  TransactionDetailViewModel();
  @override
  FutureOr<void> build() {
    _transactionRepository = ref.read(transactionRepository);
  }

  late TransactionRepository _transactionRepository;

  Future<void> deletePayments({required Transaction transaction}) async {
    try {
      state = AsyncValue.loading();
      final selectedPaymentsList = ref.read(selectedPayments);
      final ids = selectedPaymentsList.map((payment) => payment.id).toList();
      final result = await _transactionRepository.deletePayments(
        paymentsIds: ids,
        transaction: transaction,
      );
      // switch (result) {
      //   case Ok():
      //     state = AsyncValue.data(null);
      //   case Error():
      //     state = AsyncValue.error(result.error, StackTrace.current);
      // }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final isPaymentselected = Provider.family(
  (ref, Payment payment) {
    final _selectedPayments = ref.watch(selectedPayments);
    return _selectedPayments.contains(payment);
  },
);

final isPaymentselectedMode = Provider(
  (ref) {
    final _selectedPayments = ref.watch(selectedPayments);
    return _selectedPayments.isNotEmpty;
  },
);

final selectedPayments =
    NotifierProvider<SelectedPayments, List<Payment>>(SelectedPayments.new);

class SelectedPayments extends Notifier<List<Payment>> {
  @override
  List<Payment> build() {
    return [];
  }

  void addSelectedPayment(Payment payment) {
    state = [...state, payment];
  }

  void removeSelectedPayment(Payment payment) {
    final newList = [...state];
    newList.remove(payment);
    state = newList;
  }

  void clearSelectedPayments() {
    state = [];
  }
}
