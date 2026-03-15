import 'dart:async';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/result.dart';
import 'package:riverpod/riverpod.dart';

final transactionsViewModel =
    AsyncNotifierProvider.family<TransactionsViewModel, void, String>(
        TransactionsViewModel.new);

class TransactionsViewModel extends AsyncNotifier<void> {
  TransactionsViewModel(this.clientId);

  final String clientId;

  @override
  FutureOr<void> build() {
    _transactionRepository = ref.read(transactionRepository);
  }

  late TransactionRepository _transactionRepository;

  Future<void> deleteTransactions(String clientId) async {
    try {
      state = AsyncValue.loading();
      final _selectedTransactions = ref.read(selectedTransactions);
      List<String> transactionIds =
          _selectedTransactions.map((e) => e.id).toList();
      final result = await _transactionRepository.deleteTransactions(
          transactionsIds: transactionIds);
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

final isTransactionSelected = Provider.family(
  (ref, Transaction transaction) {
    final _selectedTransactions = ref.watch(selectedTransactions);
    return _selectedTransactions.contains(transaction);
  },
);

final isTransactionselectedMode = Provider(
  (ref) {
    final _selectedTransactions = ref.watch(selectedTransactions);
    return _selectedTransactions.isNotEmpty;
  },
);

final selectedTransactions =
    NotifierProvider<SelectedTransactions, List<Transaction>>(
        SelectedTransactions.new);

class SelectedTransactions extends Notifier<List<Transaction>> {
  @override
  List<Transaction> build() {
    return [];
  }

  void addSelectedTransaction(Transaction transaction) {
    state = [...state, transaction];
  }

  void removeSelectedTransaction(Transaction transaction) {
    final newList = [...state];
    newList.remove(transaction);
    state = newList;
  }

  void clearSelectedTransactions() {
    state = [];
  }
}
