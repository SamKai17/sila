import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class ClientCreateViewModel extends ChangeNotifier {
  ClientCreateViewModel({required ClientRepository clientRepository})
      : _clientRepository = clientRepository {
    addClient = Command1<void, Map<String, String>>(_addClient);
  }
  final ClientRepository _clientRepository;

  late Command1 addClient;

  Future<Result<void>> _addClient(Map<String, String> values) async {
    try {
      await _clientRepository.addClient(
          name: values['name'] ?? '',
          city: values['city'] ?? '',
          phone: values['phone'] ?? '');
      return Result.ok(null);
    } finally {}
  }
}
