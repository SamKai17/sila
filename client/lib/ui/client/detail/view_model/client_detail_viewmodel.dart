import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class ClientDetailViewModel extends ChangeNotifier {
  ClientDetailViewModel({
    // required String clientId,
    required ClientRepository clientRepository,
  }) : _clientRepository = clientRepository {
    // print("loading detail...");
    load = Command1<void, String>(_load);
    clientRepository.stream.listen(
      (event) {
        load.execute(id);
      },
    );
  }
  late String id;
  late Command1 load;
  ClientRepository _clientRepository;
  Client? _client;
  Client? get client => _client;

  Future<Result<void>> _load(String id) async {
    try {
      this.id = id;
      // print("detail load function...");
      // await Future.delayed(const Duration(seconds: 2));
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
