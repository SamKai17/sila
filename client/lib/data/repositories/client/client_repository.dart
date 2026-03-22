import 'dart:async';
import 'package:client/data/services/local/database_service.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';
import 'package:riverpod/riverpod.dart';

final clientsProvider = StreamProvider<List<Client>>(
  (ref) {
    final clientsStream = ref.watch(clientRepository).watch();
    return clientsStream;
  },
);

final clientRepository = Provider(
  (ref) {
    return ClientRepository(databaseService: ref.read(databaseService));
  },
);

class ClientRepository {
  ClientRepository({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;
  DatabaseService _databaseService;

  final _controller = StreamController<void>.broadcast();

  Stream<List<Client>> watch() async* {
    yield await getClientsList();
    await for (var _ in _controller.stream) {
      yield await getClientsList();
    }
  }

  Future<List<Client>> getClientsList() async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    // await Future.delayed(Duration(seconds: 2));
    final result = await _databaseService.getClientsList();
    switch (result) {
      case Ok():
        return result.value;
      case Error():
        throw result.error;
    }
  }

  Future<Result<void>> addClient(
      {required String name,
      required String phone,
      required String city}) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    _controller.add(null);
    final result =
        await _databaseService.addClient(name: name, phone: phone, city: city);
    return result;
  }

  // Future<Result<Client>> getClient(String id) async {
  //   if (!_databaseService.isOpen) {
  //     await _databaseService.open();
  //   }
  //   return _databaseService.getClient(id);
  // }

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
    _controller.add(null);
    return result;
  }

  Future<Result<void>> deleteClients({required List<String> ids}) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final result = await _databaseService.deleteClients(ids);
    _controller.add(null);
    return result;
  }
}
