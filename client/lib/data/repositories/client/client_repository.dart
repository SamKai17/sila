import 'dart:async';
import 'package:client/data/services/local/database_service.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';
import 'package:riverpod/riverpod.dart';

final clientRepository = Provider(
  (ref) {
    return ClientRepository(databaseService: ref.read(databaseService));
  },
);

class ClientRepository {
  ClientRepository({required DatabaseService databaseService})
      : _databaseService = databaseService;
  DatabaseService _databaseService;


  Future<Result<List<Client>>> getClientsList() async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    return _databaseService.getClientsList();
  }

  Future<Result<void>> addClient(
      {required String name,
      required String phone,
      required String city}) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    return _databaseService.addClient(name: name, phone: phone, city: city);
  }

  Future<Result<Client>> getClient(String id) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    return _databaseService.getClient(id);
  }

  Future<Result<void>> updateClient({
    required String id,
    required String name,
    required String phone,
    required String city,
  }) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final result = await _databaseService.updateClient(
        id: id, name: name, phone: phone, city: city);
    return result;
  }

  Future<Result<void>> deleteClients({required List<String> ids}) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    return _databaseService.deleteClients(ids);
  }
}