import 'package:client/data/services/database_service.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/result.dart';

class TransactionRepository {
  TransactionRepository({required DatabaseService databaseService})
      : _databaseService = databaseService;

  final DatabaseService _databaseService;
  List<Transaction> _transactions = [];

  Future<Result<void>> addTransaction() async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    List<Item> items = [
      Item(id: '1', name: 'serwal', price: 100.0, quantity: 25),
    ];
    return _databaseService.addTransaction(
      clientId: '0aea6958-beff-4902-a1cf-303b18d144de',
      paid: 100.0,
      remainder: 500.0,
      timeOfTransaction: DateTime.now().millisecondsSinceEpoch,
      totalPaid: 1000.0,
      totalPrice: 1500.0,
      items: items,
    );
  }

  Future<Result<List<Transaction>>> getTransactionsList() async {
    return _databaseService.getTransactionsList();
  }
}
