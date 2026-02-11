import 'package:client/data/services/database_service.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';

class ClientRepository {
  ClientRepository({required DatabaseService databaseService})
      : _databaseService = databaseService;
  DatabaseService _databaseService;

  Future<Result<List<Client>>> getClientsList() async {
    if (!_databaseService.isOpen) {
      await _databaseService.open();
    }
    return _databaseService.getClientsList();
  }
}
