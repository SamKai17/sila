import 'dart:async';
import 'package:client/data/services/local/database_service.dart';
import 'package:client/data/services/local/shared_preferences_service.dart';
import 'package:client/data/services/remote/api_client.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

final clientsProvider = StreamProvider<List<Client>>(
  (ref) {
    final clientsStream = ref.watch(clientRepository).watch();
    return clientsStream;
  },
);

final clientRepository = Provider(
  (ref) {
    return ClientRepository(
      databaseService: ref.read(databaseService),
      apiClient: ref.read(apiClient),
      prefs: ref.read(sharedPreferencesService),
    );
  },
);

class ClientRepository {
  ClientRepository({
    required DatabaseService databaseService,
    required ApiClient apiClient,
    required SharedPreferencesService prefs,
  })  : _databaseService = databaseService,
        _apiClient = apiClient,
        _prefs = prefs;
  DatabaseService _databaseService;
  ApiClient _apiClient;
  SharedPreferencesService _prefs;

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

// check for error in database and if there is an error don't continue the other operations
// if the database is successful try to do the remote operation
// if the remote operation failed because of invalid access token use refresh token to refresh it and retry
// if refresh token is invalid logout the user
// if the remote operation is successful set the local data to synced
  Future<Result<void>> addClient({
    required String name,
    required String phone,
    required String city,
  }) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final id = Uuid().v4();
    final result = await _databaseService.addClient(
        id: id, name: name, phone: phone, city: city);
    _controller.add(null);
    if (!_prefs.isOpen) {
      await _prefs.open();
    }
    final accessToken = await _prefs.getAccessToken();
    if (accessToken != null) {
      await _apiClient.addClient(
        accessToken: accessToken,
        id: id,
        name: name,
        phone: phone,
        city: city,
      );
    }
    return result;
  }

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
    if (!_prefs.isOpen) {
      await _prefs.open();
    }
    final accessToken = await _prefs.getAccessToken();
    if (accessToken != null) {
      await _apiClient.updateClient(
        accessToken: accessToken,
        id: id,
        name: name,
        phone: phone,
        city: city,
      );
    }
    return result;
  }

  Future<Result<void>> deleteClients({
    required List<String> ids,
  }) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final result = await _databaseService.deleteClients(ids);
    _controller.add(null);
    if (!_prefs.isOpen) {
      await _prefs.open();
    }
    final accessToken = await _prefs.getAccessToken();
    if (accessToken != null) {
      await _apiClient.deleteClients(
        accessToken: accessToken,
        ids: ids,
      );
    }
    return result;
  }
}
