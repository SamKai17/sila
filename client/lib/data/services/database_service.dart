import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  static const _tableName = 'client';
  static const _idFieldName = 'id';
  static const _nameFieldName = 'name';
  static const _phoneFieldName = 'phone';
  static const _cityFieldName = 'city';

  Database? _database;

  bool get isOpen => _database != null;

  Future<void> open() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'client_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $_tableName($_idFieldName TEXT PRIMARY KEY, $_nameFieldName TEXT, $_phoneFieldName TEXT, $_cityFieldName TEXT)');
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
      // print(clients);
      return Result.ok(clients);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> addClient(
      {required String name,
      required String phone,
      required String city}) async {
    try {
      final id = Uuid().v4();
      await _database!.insert(
        _tableName,
        {
          _idFieldName: id,
          _nameFieldName: name,
          _phoneFieldName: phone,
          _cityFieldName: city,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<Client>> getClient(String id) async {
    try {
      final List<Map<String, Object?>> clientMaps = await _database!.query(
        _tableName,
        where: '$_idFieldName = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (clientMaps.isNotEmpty) {
        return Result.ok(Client.fromJson(clientMaps.first));
      }
      return Result.error(Exception("no clients found"));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> updateClient(
      {required String id,
      required String name,
      required String phone,
      required String city}) async {
    try {
      await _database!.update(
        _tableName,
        {
          _nameFieldName: name,
          _phoneFieldName: phone,
          _cityFieldName: city,
        },
        where: '$_idFieldName = ?',
        whereArgs: [id],
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteClients(List<String> ids) async {
    try {
      final batch = _database!.batch();
      for (var id in ids) {
        batch.delete(
          _tableName,
          where: 'id = ?',
          whereArgs: [id],
        );
      }
      await batch.commit(noResult: true);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
