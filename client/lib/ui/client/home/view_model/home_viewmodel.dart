import 'dart:collection';

import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/command.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    load = Command0(_load)..execute();
  }

  late Command0 load;

  List<Client> _clients = [];
  UnmodifiableListView<Client> get clients => UnmodifiableListView(_clients);

  Future<Result<void>> _load() async {
    await Future.delayed(const Duration(seconds: 2));
    _clients.add(Client(
        id: "0", name: "oussamaaall", phone: "0697878", city: "casablanca"));
    _clients.add(
        Client(id: "0", name: "aya", phone: "0697878", city: "casablanca"));
    return Result.ok(null);
  }
}
