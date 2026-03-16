import 'dart:async';
import 'package:client/data/services/local/database_service.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionsProvider = StreamProvider.family<List<Transaction>, String>(
  (ref, clientId) {
    final transactionsListStream =
        ref.watch(transactionRepository).watch(clientId: clientId);
    return transactionsListStream;
  },
);
final transactionProvider = StreamProvider.family<Transaction, String>((ref, transactionId) {
    final transactionStream =
        ref.watch(transactionRepository).watchTransaction(transactionId: transactionId);
    return transactionStream;

},);

final transactionRepository = Provider(
  (ref) {
    return TransactionRepository(databaseService: ref.read(databaseService));
  },
);

class TransactionRepository {
  TransactionRepository({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  final _transactionsListController = StreamController<void>.broadcast();
  final _transactionController = StreamController<void>.broadcast();

  Stream<List<Transaction>> watch({
    required String clientId,
  }) async* {
    yield await getTransactionsList(clientId: clientId);
    await for (var _ in _transactionsListController.stream) {
      yield await getTransactionsList(clientId: clientId);
    }
  }

  Stream<Transaction> watchTransaction({
    required String transactionId,
  }) async* {
    yield await getTransaction(transactionId: transactionId);
    await for (var _ in _transactionController.stream) {
      yield await getTransaction(transactionId: transactionId);
    }
  }

  Future<List<Transaction>> getTransactionsList(
      {required String clientId}) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final transactions =
        await _databaseService.getTransactionsList(clientId: clientId);
    switch (transactions) {
      case Ok():
        return transactions.value
            .map(
              (transaction) => Transaction(
                id: transaction.id,
                totalPrice: transaction.totalPrice,
                remainder: transaction.remainder,
                totalPaid: transaction.totalPaid,
                type: transaction.type,
                timeOfTransaction: transaction.timeOfTransaction,
                clientId: transaction.clientId,
              ),
            )
            .toList();
      case Error():
        throw transactions.error;
    }
  }

  Future<Result<void>> addPayment({
    required double amount,
    required Transaction transaction,
  }) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    int timeOfPayment = DateTime.now().millisecondsSinceEpoch;
    double remainder = transaction.remainder - amount;
    double totalPaid = transaction.totalPaid + amount;
    final result = _databaseService.addPayment(
      amount: amount,
      transactionId: transaction.id,
      remainder: remainder,
      timeOfPayment: timeOfPayment,
      totalPaid: totalPaid,
    );
    _transactionController.add(null);
    _transactionsListController.add(null);
    return result;
  }

  Future<Result<String>> addTransaction({
    required double totalPrice,
    required double totalPaid,
    required double remainder,
    required double paid,
    required List<Item> items,
    required String type,
    required String clientId,
  }) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final result = _databaseService.addTransaction(
      clientId: clientId,
      paid: paid,
      remainder: remainder,
      type: type,
      timeOfTransaction: DateTime.now().millisecondsSinceEpoch,
      totalPaid: totalPaid,
      totalPrice: totalPrice,
      items: items,
    );
    _transactionsListController.add(null);
    return result;
  }

  Future<Result<void>> deleteTransactions(
      {required List<String> transactionsIds}) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    _transactionsListController.add(null);
    final result =
        _databaseService.deleteTransactions(transactionsIds: transactionsIds);
    return result;
  }

  Future<Transaction> getTransaction({
    required String transactionId,
  }) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final itemsResult =
        await _databaseService.getItems(transactionId: transactionId);
    List<Item> items;
    switch (itemsResult) {
      case Ok():
        items = itemsResult.value;
      case Error():
        throw itemsResult.error;
        // return Result.error(itemsResult.error);
    }
    final paymentsResult =
        await _databaseService.getPayments(transactionId: transactionId);
    List<Payment> payments;
    switch (paymentsResult) {
      case Ok():
        payments = paymentsResult.value;
      case Error():
        throw paymentsResult.error;
        // return Result.error(paymentsResult.error);
    }
    final transactionResult =
        await _databaseService.getTransaction(transactionId: transactionId);
    switch (transactionResult) {
      case Ok():
        final transactionLocal = transactionResult.value;
        final transaction = Transaction(
          id: transactionLocal.id,
          clientId: transactionLocal.clientId,
          remainder: transactionLocal.remainder,
          timeOfTransaction: transactionLocal.timeOfTransaction,
          totalPaid: transactionLocal.totalPaid,
          totalPrice: transactionLocal.totalPrice,
          type: transactionLocal.type,
          items: items,
          payments: payments,
        );
        return transaction;
      case Error():
        throw transactionResult.error;
        // return Result.error(transactionResult.error);
    }
  }
}
