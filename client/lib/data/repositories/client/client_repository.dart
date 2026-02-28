import 'dart:async';
import 'package:client/data/services/local/database_service.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';

class ClientRepository {
  ClientRepository({required DatabaseService databaseService})
      : _databaseService = databaseService;
  DatabaseService _databaseService;
  StreamController _controller = StreamController<void>.broadcast();
  Stream get stream => _controller.stream;

  List<Client> _selectedClients = [];

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
    _controller.sink.add(null);
    return _databaseService.addClient(name: name, phone: phone, city: city);
  }

  Future<Result<Client>> getClient(String id) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    return _databaseService.getClient(id);
  }

  Future<Result<void>> updateClient(
      {required String id,
      required String name,
      required String phone,
      required String city}) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final result = await _databaseService.updateClient(
        id: id, name: name, phone: phone, city: city);
    _controller.sink.add(null);
    return result;
  }

  Future<Result<void>> deleteClients() async {
    final ids = _selectedClients.map((client) => client.id).toList();
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    return _databaseService.deleteClients(ids);
  }

  bool get selectedMode => _selectedClients.length > 0;

  void addSelectedClient(Client client) {
    _selectedClients.add(client);
  }

  void removeSelectedClient(Client client) {
    _selectedClients.remove(client);
  }

  void clearSelectedClients() {
    _selectedClients.clear();
  }

  bool isSelected(Client client) {
    return _selectedClients.contains(client);
  }
}