import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const _tableName = 'client';

  Database? _database;

  bool get isOpen => _database != null;

  Future<void> open() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'client_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $_tableName(id TEXT PRIMARY KEY, name TEXT, phone TEXT, city TEXT)');
      },
      version: 1,
    );
  }

  Future<Result<List<Client>>> getClientsList() async {
    try {
      final List<Map<String, Object?>> clientMaps =
          await _database!.query(_tableName);
      final List<Client> clients =
          clientMaps.map((client) => Client.fromJson(client)).toList();
      print(clients);
      return Result.ok(clients);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
