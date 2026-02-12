import 'dart:collection';
import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required ClientRepository clientRepository})
      : _clientRepository = clientRepository {
    print("constructing again...");
    load = Command0(_load)..execute();
  }
  final ClientRepository _clientRepository;

  late Command0 load;

  List<Client> _clients = [];
  UnmodifiableListView<Client> get clients => UnmodifiableListView(_clients);

  Future<Result<void>> _load() async {
    print("loaddingg....");
    // await Future.delayed(const Duration(seconds: 2));
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
}
