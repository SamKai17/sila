import 'package:client/data/services/local/database_service.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/result.dart';

class TransactionRepository {
  TransactionRepository({required DatabaseService databaseService})
      : _databaseService = databaseService;

  final DatabaseService _databaseService;
  List<Transaction> _transactions = [];

  Future<Result<void>> addPayment(
      {required double amount, required Transaction transaction}) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    int timeOfPayment = DateTime.now().millisecondsSinceEpoch;
    double remainder = transaction.remainder - amount;
    double totalPaid = transaction.totalPaid + amount;
    return _databaseService.addPayment(
      amount: amount,
      transactionId: transaction.id,
      remainder: remainder,
      timeOfPayment: timeOfPayment,
      totalPaid: totalPaid,
    );
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
    return _databaseService.addTransaction(
      clientId: clientId,
      paid: paid,
      remainder: remainder,
      type: type,
      timeOfTransaction: DateTime.now().millisecondsSinceEpoch,
      totalPaid: totalPaid,
      totalPrice: totalPrice,
      items: items,
    );
  }

  Future<Result<void>> deleteTransactions(
      {required List<String> transactionsIds}) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    return _databaseService.deleteTransactions(
        transactionsIds: transactionsIds);
  }

  Future<Result<List<Transaction>>> getTransactionsList(
      {required String clientId}) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final transactions =
        await _databaseService.getTransactionsList(clientId: clientId);
    switch (transactions) {
      case Ok():
        _transactions = transactions.value
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
        return Result.error(transactions.error);
    }
    return Result.ok(_transactions);
  }

  Future<Result<Transaction>> getTransaction(
      {required String transactionId}) async {
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
        return Result.error(itemsResult.error);
    }
    final paymentsResult =
        await _databaseService.getPayments(transactionId: transactionId);
    List<Payment> payments;
    switch (paymentsResult) {
      case Ok():
        payments = paymentsResult.value;
      case Error():
        return Result.error(paymentsResult.error);
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
        // print('tran: $transaction');
        return Result.ok(transaction);
      case Error():
        return Result.error(transactionResult.error);
    }
  }
}
