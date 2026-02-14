import 'dart:collection';
import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required ClientRepository clientRepository})
      : _clientRepository = clientRepository {
    load = Command0(_load)..execute();
    deleteClients = Command0(_deleteClients);
  }
  final ClientRepository _clientRepository;

  late Command0 load;
  late Command0 deleteClients;

  List<Client> _clients = [];

  bool get selectedMode => _clientRepository.selectedMode;

  bool isSelected(Client client) {
    return _clientRepository.isSelected(client);
  }

  UnmodifiableListView<Client> get clients => UnmodifiableListView(_clients);

  Future<Result<void>> _load() async {
    // await Future.delayed(const Duration(seconds: 2));
    print("loaddingg....");
    try {
      final result = await _clientRepository.getClientsList();
      switch (result) {
        case Ok():
          _clients = result.value;
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
        case Ok():
          print("success");
        // return Result.ok(null);
        case Error():
          // print("error");
          return Result.error(result.error);
      }
      final clientResult = await _clientRepository.getClientsList();
      switch (clientResult) {
        case Ok():
          _clients = clientResult.value;
        case Error():
        // return Result.error(clientResult.error);
      }
      return clientResult;
      // return Result.ok(null);
    } finally {
      _clientRepository.clearSelectedClients();
      notifyListeners();
    }
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