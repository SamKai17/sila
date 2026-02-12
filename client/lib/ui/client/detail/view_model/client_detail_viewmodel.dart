import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class ClientDetailViewModel extends ChangeNotifier {
  ClientDetailViewModel(
      {required String clientId, required ClientRepository clientRepository})
      : _clientRepository = clientRepository {
    load = Command1<void, String>(_load)..execute(clientId);
  }

  late Command1 load;
  ClientRepository _clientRepository;
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
}
