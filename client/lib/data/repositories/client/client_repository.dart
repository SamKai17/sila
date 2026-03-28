import 'dart:async';
import 'package:client/data/services/local/database_service.dart';
import 'package:client/data/services/remote/api_client.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';
import 'package:dio/dio.dart';
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
      // authApiClient: ref.read(authApiClient),
    );
  },
);

class ClientRepository {
  ClientRepository({
    required DatabaseService databaseService,
    required ApiClient apiClient,
    // required AuthApiClient authApiClient,
  })  : _databaseService = databaseService,
        _apiClient = apiClient;
  // _authApiClient = authApiClient;

  DatabaseService _databaseService;
  ApiClient _apiClient;
  // AuthApiClient _authApiClient;

  final _controller = StreamController<void>.broadcast();
  final _authController = StreamController<void>.broadcast();

  Stream<void> observeAuth() => _authController.stream;

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
    final localResult = await _databaseService.addClient(
      id: id,
      name: name,
      phone: phone,
      city: city,
    );
    switch (localResult) {
      case Ok():
        _controller.add(null);
      case Error():
        return localResult;
    }
    final remoteResult = await _apiClient.addClient(
      id: id,
      name: name,
      phone: phone,
      city: city,
    );
    switch (remoteResult) {
      case Ok():
        break;
      case Error():
        _authController.add(null);
      // if (remoteResult.error is RevokeTokenException) {
      //   return remoteResult;
      //   // logout user
      // }
    }
    return localResult;
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
    final localResult = await _databaseService.updateClient(
        id: id, name: name, phone: phone, city: city);
    _controller.add(null);
    final remoteResult = await _apiClient.updateClient(
      id: id,
      name: name,
      phone: phone,
      city: city,
    );
    return localResult;
  }

  Future<Result<void>> deleteClients({
    required List<String> ids,
  }) async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    final result = await _databaseService.deleteClients(ids);
    _controller.add(null);
    await _apiClient.deleteClients(
      ids: ids,
    );
    return result;
  }

}
