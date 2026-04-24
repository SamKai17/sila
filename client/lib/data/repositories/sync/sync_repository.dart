import 'package:client/data/services/local/database_service.dart';
import 'package:client/data/services/remote/api_client.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final syncRepository = Provider(
  (ref) {
    return SyncRepository(
      databaseService: ref.read(databaseService),
      apiClient: ref.read(apiClient(ref.read(dio))),
    );
  },
);

class SyncRepository {
  SyncRepository({
    required DatabaseService databaseService,
    required ApiClient apiClient,
  })  : _databaseService = databaseService,
        _apiClient = apiClient;

  late DatabaseService _databaseService;
  late ApiClient _apiClient;
  final _log = Logger('SyncRepository');

  Future<void> syncClientsToRemote() async {
    // print('sync clients');
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final unsyncedClientsResult = await _databaseService.fetchUnsyncedClients();
    switch (unsyncedClientsResult) {
      case Ok():
        // print(unsyncedClientsResult.value);
        final unsyncedClients = unsyncedClientsResult.value;
        for (var client in unsyncedClients) {
          if (client.isDeleted == 1) {
            // await _databaseService.synchronizeClient(id: client.id);
            // break;
            final remoteResult = await _apiClient.deleteClient(id: client.id);
            switch (remoteResult) {
              case Ok():
                _log.finer('client ${client.id} is synced');
                await _databaseService.synchronizeClient(id: client.id);
              case Error():
                _log.warning('client ${client.id} was not synced');
                break;
            }
          } else {
            final remoteResult = await _apiClient.addClient(
              id: client.id,
              name: client.name,
              phone: client.phone,
              city: client.city,
            );
            switch (remoteResult) {
              case Ok():
                _log.finer('client ${client.id} is synced');
                await _databaseService.synchronizeClient(id: client.id);
              case Error():
                _log.warning('client ${client.id} was not synced');
                break;
            }
          }
        }
      case Error():
        break;
    }
  }

  Future<void> syncTransactionsToRemote() async {
    // print('sync transactions');
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final unsyncedTransactionsResult =
        await _databaseService.fetchUnsyncedTransactions();
    switch (unsyncedTransactionsResult) {
      case Ok():
        final unsyncedTransactions = unsyncedTransactionsResult.value;
        // print(unsyncedTransactions);
        for (var transaction in unsyncedTransactions) {
          // print(transaction);
          if (transaction.isDeleted == 1) {
            print('deleting...');
            final remoteResult =
                await _apiClient.deleteTransaction(id: transaction.id);
            switch (remoteResult) {
              case Ok():
                print('synced transaction ${transaction.id}');
                await _databaseService.synchronizeTransaction(
                    id: transaction.id);
              case Error():
                break;
            }
            // delete transaction
          } else {
            print('creating...');
            final itemsResult = await _databaseService.fetchItems(
                transactionId: transaction.id);
            switch (itemsResult) {
              case Ok():
                break;
              case Error():
                continue;
            }
            final paymentsResult = await _databaseService.fetchPayments(
                transactionId: transaction.id);
            switch (paymentsResult) {
              case Ok():
                break;
              case Error():
                continue;
            }
            final remoteResult = await _apiClient.addTransaction(
              id: transaction.id,
              totalPrice: transaction.totalPrice,
              totalPaid: transaction.totalPaid,
              remainder: transaction.remainder,
              timeOfTransaction: transaction.timeOfTransaction,
              type: transaction.type,
              clientId: transaction.clientId,
              items: itemsResult.value,
              payments: paymentsResult.value,
            );
            switch (remoteResult) {
              case Ok():
                print('synced transaction ${transaction.id}');
                await _databaseService.synchronizeTransaction(
                    id: transaction.id);
              case Error():
                break;
            }
          }
        }
      case Error():
        break;
    }
  }

  Future<void> syncClientsToLocal() async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    print('syncing to local');
    final clientsListResult = await _apiClient.getClientsList();
    switch (clientsListResult) {
      case Ok():
        final clientsList = clientsListResult.value;
        print(clientsList);
        final localResult = await _databaseService.syncClients(clientsList);
        switch (localResult) {
          case Ok():
            print('success syncing data');
          case Error():
            break;
        }
      // print(clientsList);
      // sync to database
      case Error():
        break;
    }
  }
}
