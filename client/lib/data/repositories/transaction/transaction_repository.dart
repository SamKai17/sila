import 'dart:async';
import 'package:client/data/services/local/database_service.dart';
import 'package:client/data/services/remote/api_client.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final transactionsProvider = StreamProvider.family<List<Transaction>, String>(
  (ref, clientId) {
    final transactionsListStream =
        ref.read(transactionRepository).watch(clientId: clientId);
    return transactionsListStream;
  },
);
final transactionProvider = StreamProvider.family<Transaction, String>(
  (ref, transactionId) {
    final transactionStream = ref
        .read(transactionRepository)
        .watchTransaction(transactionId: transactionId);
    return transactionStream;
  },
);

final transactionRepository = Provider(
  (ref) {
    return TransactionRepository(
      databaseService: ref.read(databaseService),
      apiClient: ref.read(apiClient),
    );
  },
);

class TransactionRepository {
  TransactionRepository({
    required DatabaseService databaseService,
    required ApiClient apiClient,
  })  : _databaseService = databaseService,
        _apiClient = apiClient;

  final DatabaseService _databaseService;
  final ApiClient _apiClient;

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
    final result = await _databaseService.addPayment(
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

  Future<Result<void>> deletePayments({
    required List<String> paymentsIds,
    required Transaction transaction,
  }) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    List<Payment> payments = transaction.payments ?? [];
    double totalPaid = 0;
    payments.forEach(
      (payment) {
        int index = paymentsIds.indexWhere((id) => payment.id == id);
        if (index == -1) {
          totalPaid += payment.amount;
        }
      },
    );
    double remainder = transaction.totalPrice - totalPaid;
    final result = await _databaseService.deletePayments(
      paymentsIds: paymentsIds,
      totalPaid: totalPaid,
      remainder: remainder,
      transactionId: transaction.id,
    );
    _transactionController.add(null);
    _transactionsListController.add(null);
    return result;
  }

  Future<Result<void>> updatePayment({
    required Transaction transaction,
    required Payment payment,
    required double newAmount,
  }) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final double oldAmount =
        transaction.payments?.firstWhere((e) => e.id == payment.id).amount ??
            0.0;
    double totalPaid = (transaction.totalPaid - oldAmount) + newAmount;
    double remainder = transaction.totalPrice - totalPaid;
    final result = await _databaseService.updatePayment(
      transactionId: transaction.id,
      totalPaid: totalPaid,
      remainder: remainder,
      paymentId: payment.id,
      paid: newAmount,
    );
    _transactionController.add(null);
    _transactionsListController.add(null);
    return result;
  }

  Future<Result<void>> updateItems({
    required List<Item> itemsToAdd,
    required List<Item> itemsToDelete,
    required Transaction transaction,
  }) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    double total = 0.0;
    for (var item in itemsToAdd) {
      total += item.price * item.quantity;
    }
    double remainder = total - transaction.totalPaid;
    final result = await _databaseService.updateItems(
      transactionId: transaction.id,
      total: total,
      remainder: remainder,
      itemsToAdd: itemsToAdd,
      itemsToDelete: itemsToDelete,
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
    final timeOfTransaction = DateTime.now().millisecondsSinceEpoch;
    final transactionId = Uuid().v4();
    final paymentId = Uuid().v4();
    final result = await _databaseService.addTransaction(
      transactionId: transactionId,
      paymentId: paymentId,
      clientId: clientId,
      paid: paid,
      remainder: remainder,
      type: type,
      timeOfTransaction: timeOfTransaction,
      totalPaid: totalPaid,
      totalPrice: totalPrice,
      items: items,
    );
    await _apiClient.addTransaction(
      id: transactionId,
      totalPrice: totalPrice,
      totalPaid: totalPaid,
      remainder: remainder,
      timeOfTransaction: timeOfTransaction,
      type: type,
      clientId: clientId,
      items: items,
      paymentId: paymentId 
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
        await _databaseService.deleteTransactions(transactionsIds: transactionsIds);
      await _apiClient.deleteTransactions(transactionsIds: transactionsIds);
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
    }
    final paymentsResult =
        await _databaseService.getPayments(transactionId: transactionId);
    List<Payment> payments;
    switch (paymentsResult) {
      case Ok():
        payments = paymentsResult.value;
      case Error():
        throw paymentsResult.error;
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
    }
  }
}
