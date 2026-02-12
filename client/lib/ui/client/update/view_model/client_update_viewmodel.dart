import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class ClientUpdateViewModel extends ChangeNotifier {
  ClientUpdateViewModel({required ClientRepository clientRepository, required String clientId})
      : _clientRepository = clientRepository {
    load = Command1<void, String>(_load)..execute(clientId);
    updateClient = Command1<void, Map<String, String>>(_updateClient);
  }
  final ClientRepository _clientRepository;
  late Command1 updateClient;
  late Command1 load;
  Client? _client;
  Client? get client => _client;

  
    Future<Result<void>> _load(String id) async {
    try {
      final result = await _clientRepository.getClient(id);
      switch (result) {
        case Ok():
          _client = result.value;
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _updateClient(Map<String, String> values) async {
    try {
      final result = await _clientRepository.updateClient(
          id: values['id']!,
          name: values['name']!,
          phone: values['phone']!,
          city: values['city']!);

      switch (result) {
        case Ok():
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } finally {
      notifyListeners();
    }
  }
}
