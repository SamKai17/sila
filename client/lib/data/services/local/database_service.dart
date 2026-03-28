import 'package:client/data/services/local/models/transaction/transaction_local_model.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:client/ui/transaction/items_edit/view_model/items_edit_viewmodel.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

final databaseService = Provider(
  (ref) {
    return DatabaseService();
  },
);

class DatabaseService {
  static const _clientTable = 'clients';
  static const _clientIdField = 'id';
  static const _clientNameField = 'name';
  static const _clientPhoneField = 'phone';
  static const _clientCityField = 'city';
  static const _clientSynchronizedField = 'synchronized';

  static const _transactionTable = 'transactions';
  static const _transactionIdField = 'id';
  static const _transactionTotalPriceField = 'total_price';
  static const _transactionTotalPaidField = 'total_paid';
  static const _transactionTypeField = 'type';
  static const _transactionRemainderField = 'remainder';
  static const _transactionTimeOfTransactionField = 'time_of_transaction';
  static const _transactionClientIdField = 'client_id';

  static const _itemTable = 'items';
  static const _itemIdField = 'id';
  static const _itemNameField = 'name';
  static const _itemPriceField = 'price';
  static const _itemQuantityField = 'quantity';
  static const _itemTransactionIdField = 'transaction_id';

  static const _paymentTable = 'payments';
  static const _paymentIdField = 'id';
  static const _paymentAmountField = 'amount';
  static const _paymentTimeOfPaymentField = 'time_of_payment';
  static const _paymentTransactionIdField = 'transaction_id';

  Database? _database;

  bool get isOpen => _database != null;

  Future<void> open() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'client_database.db'),
      onOpen: (db) async {
        print("opening db...");
        // db.delete(_transactionTable,
        //     where: '$_transactionIdField = ?',
        //     whereArgs: ["c6e920d8-be61-4c26-b782-2fe51001aa63"]);
        // print('success');
        // print(await db.query('sqlite_master', where: 'name = ?', whereArgs: ['transactions']));
        // db.rawDelete('DELETE FROM $_transactionTable');
        // db.execute('DROP TABLE IF EXISTS transactions');
        // db.execute('DROP TABLE IF EXISTS items');
        // db.execute('DROP TABLE IF EXISTS payments');
        // db.execute('DROP TABLE IF EXISTS clients');
      },
      onCreate: (db, version) {
        print("creating db...");
        db.execute('''CREATE TABLE $_clientTable(
            $_clientIdField TEXT PRIMARY KEY,
            $_clientNameField TEXT,
            $_clientPhoneField TEXT,
            $_clientCityField TEXT,
            $_clientSynchronizedField INTEGER DEFAULT 0
            )
        ''');
        db.execute('''CREATE TABLE $_transactionTable(
            $_transactionIdField TEXT PRIMARY KEY,
            $_transactionTotalPriceField REAL,
            $_transactionTotalPaidField REAL,
            $_transactionTypeField TEXT,
            $_transactionRemainderField REAL,
            $_transactionTimeOfTransactionField INTEGER,
            $_transactionClientIdField TEXT,
            FOREIGN KEY($_transactionClientIdField) REFERENCES $_clientTable($_clientIdField) ON DELETE CASCADE
            )
        ''');
        db.execute('''CREATE TABLE $_itemTable(
            $_itemIdField TEXT PRIMARY KEY,
            $_itemNameField TEXT,
            $_itemQuantityField INTEGER,
            $_itemPriceField REAL,
            $_itemTransactionIdField TEXT,
            FOREIGN KEY($_itemTransactionIdField) REFERENCES $_transactionTable($_transactionIdField) ON DELETE CASCADE
            )
        ''');
        db.execute('''CREATE TABLE $_paymentTable(
            $_paymentIdField TEXT PRIMARY KEY,
            $_paymentAmountField REAL,
            $_paymentTimeOfPaymentField INTEGER,
            $_paymentTransactionIdField TEXT,
            FOREIGN KEY($_paymentTransactionIdField) REFERENCES $_transactionTable($_transactionIdField) ON DELETE CASCADE
            )
        ''');
      },
      version: 1,
      onConfigure: (db) {
        // print("configuring db...");
        db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<Result<List<Item>>> getItems({
    required String transactionId,
  }) async {
    try {
      final List<Map<String, Object?>> itemsMap = await _database!.query(
        _itemTable,
        where: '$_itemTransactionIdField = ?',
        whereArgs: [transactionId],
      );
      final items = itemsMap.map((e) => Item.fromJson(e)).toList();
      return Result.ok(items);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<Payment>>> getPayments({
    required String transactionId,
  }) async {
    try {
      final List<Map<String, Object?>> paymentsMap = await _database!.query(
        _paymentTable,
        where: '$_paymentTransactionIdField = ?',
        whereArgs: [transactionId],
      );
      final payments = paymentsMap.map((e) => Payment.fromJson(e)).toList();
      return Result.ok(payments);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<TransactionLocalModel>> getTransaction({
    required String transactionId,
  }) async {
    try {
      final List<Map<String, Object?>> transactionMap = await _database!.query(
        _transactionTable,
        where: '$_transactionIdField = ?',
        whereArgs: [transactionId],
        limit: 1,
      );
      if (transactionMap.isNotEmpty) {
        final TransactionLocalModel transaction =
            TransactionLocalModel.fromJson(transactionMap.first);
        return Result.ok(transaction);
      } else {
        throw Exception('transaction not found');
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<TransactionLocalModel>>> getTransactionsList({
    required String clientId,
  }) async {
    try {
      final List<Map<String, Object?>> transactionsMap = await _database!.query(
        _transactionTable,
        where: '$_transactionClientIdField = ?',
        whereArgs: [clientId],
      );
      final transactions = transactionsMap.map((t) {
        return TransactionLocalModel.fromJson(t);
      }).toList();
      return Result.ok(transactions);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<TransactionLocalModel>>> getItemsList({
    required String transactionId,
  }) async {
    try {
      final List<Map<String, Object?>> itemsMap = await _database!.query(
        _itemTable,
        where: '$_itemTransactionIdField = ?',
        whereArgs: [transactionId],
      );
      final items = itemsMap.map((t) {
        return TransactionLocalModel.fromJson(t);
      }).toList();
      return Result.ok(items);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> addPayment({
    required String transactionId,
    required double amount,
    required int timeOfPayment,
    required double remainder,
    required double totalPaid,
  }) async {
    try {
      final String id = Uuid().v4();
      await _database!.transaction(
        (txn) async {
          await txn.insert(
            _paymentTable,
            {
              _paymentIdField: id,
              _paymentAmountField: amount,
              _paymentTimeOfPaymentField: timeOfPayment,
              _paymentTransactionIdField: transactionId
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          await txn.update(
            _transactionTable,
            {
              _transactionRemainderField: remainder,
              _transactionTotalPaidField: totalPaid,
            },
            where: '$_transactionIdField = ?',
            whereArgs: [transactionId],
          );
        },
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deletePayments({
    required List<String> paymentsIds,
    required double totalPaid,
    required double remainder,
    required String transactionId,
  }) async {
    try {
      await _database!.transaction(
        (txn) async {
          await txn.update(
            _transactionTable,
            {
              _transactionTotalPaidField: totalPaid,
              _transactionRemainderField: remainder
            },
            where: '$_transactionIdField = ?',
            whereArgs: [transactionId],
          );
          for (var id in paymentsIds) {
            await txn.delete(
              _paymentTable,
              where: '$_paymentIdField = ?',
              whereArgs: [id],
            );
          }
        },
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> updatePayment({
    required String transactionId,
    required double totalPaid,
    required double remainder,
    required String paymentId,
    required double paid,
  }) async {
    // transactionId
    // totalPaid
    // paymentId
    // amount
    try {
      await _database!.transaction(
        (txn) async {
          await txn.update(
            _transactionTable,
            {
              _transactionTotalPaidField: totalPaid,
              _transactionRemainderField: remainder,
            },
            where: '$_transactionIdField = ?',
            whereArgs: [transactionId],
          );
          await txn.update(
            _paymentTable,
            {
              _paymentAmountField: paid,
            },
            where: '$_paymentIdField = ?',
            whereArgs: [paymentId],
          );
        },
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> updateItems({
    required String transactionId,
    required double total,
    required double remainder,
    required List<Item> itemsToAdd,
    required List<Item> itemsToDelete,
  }) async {
    try {
      await _database!.transaction(
        (txn) async {
          await txn.update(
            _transactionTable,
            {
              _transactionTotalPriceField: total,
              _transactionRemainderField: remainder,
            },
            where: '$_transactionIdField = ?',
            whereArgs: [transactionId],
          );
          itemsToAdd.forEach(
            (item) async {
              await txn.insert(
                _itemTable,
                {
                  _itemIdField: item.id,
                  _itemNameField: item.name,
                  _itemQuantityField: item.quantity,
                  _itemPriceField: item.price,
                  _itemTransactionIdField: transactionId,
                },
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            },
          );
          itemsToDelete.forEach(
            (item) async {
              await txn.delete(
                _itemTable,
                where: '$_itemIdField = ?',
                whereArgs: [item.id],
              );
            },
          );
        },
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<String>> addTransaction({
    required String transactionId,
    required String paymentId,
    required double totalPrice,
    required double totalPaid,
    required double remainder,
    required int timeOfTransaction,
    required String clientId,
    required double paid,
    required String type,
    required List<Item> items,
  }) async {
    try {
      await _database!.transaction(
        (txn) async {
          await txn.insert(
            _transactionTable,
            {
              _transactionIdField: transactionId,
              _transactionTotalPriceField: totalPrice,
              _transactionTotalPaidField: totalPaid,
              _transactionTypeField: type,
              _transactionRemainderField: remainder,
              _transactionTimeOfTransactionField: timeOfTransaction,
              _transactionClientIdField: clientId,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          items.forEach(
            (item) async {
              await txn.insert(_itemTable, {
                _itemIdField: item.id,
                _itemNameField: item.name,
                _itemQuantityField: item.quantity,
                _itemPriceField: item.price,
                _itemTransactionIdField: transactionId,
              });
            },
          );
          await txn.insert(_paymentTable, {
            _paymentIdField: paymentId,
            _paymentAmountField: paid,
            _paymentTimeOfPaymentField: timeOfTransaction,
            _paymentTransactionIdField: transactionId,
          });
        },
      );
      return Result.ok(transactionId);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteTransactions({
    required List<String> transactionsIds,
  }) async {
    try {
      final batch = _database!.batch();
      for (var id in transactionsIds) {
        batch.delete(
          _transactionTable,
          where: '$_transactionIdField = ?',
          whereArgs: [id],
        );
      }
      await batch.commit(noResult: true);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<Client>>> getClientsList() async {
    try {
      final List<Map<String, Object?>> clientsMap =
          await _database!.query(_clientTable);
      final List<Client> clients =
          clientsMap.map((client) => Client.fromJson(client)).toList();
      // print(clients);
      return Result.ok(clients);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> addClient({
    required String id,
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      await _database!.insert(
        _clientTable,
        {
          _clientIdField: id,
          _clientNameField: name,
          _clientPhoneField: phone,
          _clientCityField: city,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> synchronizeClient({
    required String id,
  }) async {
    try {
      await _database!.update(
        _clientTable,
        {
          _clientSynchronizedField: 1,
        },
        where: '$_clientIdField = ?',
        whereArgs: [id],
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<Client>> getClient(String id) async {
    try {
      final List<Map<String, Object?>> clientMaps = await _database!.query(
        _clientTable,
        where: '$_clientIdField = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (clientMaps.isNotEmpty) {
        return Result.ok(Client.fromJson(clientMaps.first));
      }
      return Result.error(Exception("no clients found"));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> updateClient({
    required String id,
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      await _database!.update(
        _clientTable,
        {
          _clientNameField: name,
          _clientPhoneField: phone,
          _clientCityField: city,
        },
        where: '$_clientIdField = ?',
        whereArgs: [id],
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteClients(List<String> ids) async {
    try {
      final batch = _database!.batch();
      for (var id in ids) {
        batch.delete(
          _clientTable,
          where: '$_clientIdField = ?',
          whereArgs: [id],
        );
      }
      await batch.commit(noResult: true);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
