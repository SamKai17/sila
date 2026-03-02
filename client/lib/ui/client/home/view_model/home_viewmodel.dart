import 'dart:collection';
import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required ClientRepository clientRepository})
      : _clientRepository = clientRepository {
    load = Command0(_load);
    deleteClients = Command0(_deleteClients);
    clientRepository.stream.listen(
      (event) {
        load.execute();
      },
    );
  }
  final ClientRepository _clientRepository;

  late Command0 load;
  late Command0 deleteClients;

  List<Client> _clients = [];
  List<Client> _filteredClients = [];

  bool get selectedMode => _clientRepository.selectedMode;

  bool isSelected(Client client) {
    return _clientRepository.isSelected(client);
  }

  UnmodifiableListView<Client> get clients => UnmodifiableListView(_clients);
  UnmodifiableListView<Client> get filteredClients =>
      UnmodifiableListView(_filteredClients);

  Future<Result<void>> _load() async {
    try {
      final result = await _clientRepository.getClientsList();
      switch (result) {
        case Ok():
          _clients = result.value;
          _filteredClients = _clients;
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _deleteClients() async {
    try {
      final result = await _clientRepository.deleteClients();
      switch (result) {
        case Error():
          return Result.error(result.error);
        case Ok():
      }
      final clientResult = await _clientRepository.getClientsList();
      switch (clientResult) {
        case Ok():
          _clients = clientResult.value;
          _filteredClients = _clients;
        case Error():
          return Result.error(clientResult.error);
      }
      return clientResult;
    } finally {
      _clientRepository.clearSelectedClients();
      notifyListeners();
    }
  }

  void filter(String query) {
    _filteredClients =
        _clients.where((client) => client.name.contains(query)).toList();
    notifyListeners();
  }

  void addSelectedClient(Client client) {
    _clientRepository.addSelectedClient(client);
    notifyListeners();
  }

  void removeSelectedClient(Client client) {
    _clientRepository.removeSelectedClient(client);
    notifyListeners();
  }

  void clearSelectedClients() {
    _clientRepository.clearSelectedClients();
    notifyListeners();
  }
}
