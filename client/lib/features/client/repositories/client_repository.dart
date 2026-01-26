import 'dart:convert';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/client/model/client_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  return ClientRepository();
});

class ClientRepository {
  Future<Either<AppFailure, List<ClientModel>>> getAllClients(
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('${ServerConstant.serverURL}/api/clients/'),
        headers: {'Authorization': 'Bearer $token'},
      );
      // print(response.body);
      print("status|: ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        // print(data);
        final clientList = data.map((e) {
          return ClientModel.fromMap(e);
        }).toList();
        // print(clientList);
        return Right(clientList);
      }
      return Left(AppFailure());
    } catch (e) {
      // print(e);
      return Left(AppFailure());
    }
  }

  Future<Either<AppFailure, ClientModel>> addClient({
    required String token,
    String? name,
    String? phone,
    String? city,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ServerConstant.serverURL}/api/client/"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'name': name, 'phone': phone, 'city': city}),
      );
      if (response.statusCode == 201) {
        return Right(ClientModel.fromJson(response.body));
      }
      return Left(AppFailure());
    } catch (e) {
      return Left(AppFailure());
    }
  }

  Future<Either<AppFailure, ClientModel>> updateClient({
    required String token,
    required int id,
    String? name,
    String? phone,
    String? city,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ServerConstant.serverURL}/api/client/$id/"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'name': name, 'phone': phone, 'city': city}),
      );
      if (response.statusCode == 200) {
        return Right(ClientModel.fromJson(response.body));
      }
      return Left(AppFailure());
    } catch (e) {
      return Left(AppFailure());
    }
  }

  Future<Either<AppFailure, List<int>>> removeClient({
    required String token,
    required List<int> ids,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ServerConstant.serverURL}/api/clients/delete/"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'ids': ids}),
      );
      final data = json.decode(response.body) as Map<String, dynamic>;
      final deletedClients = List<int>.from(data['ids']);
      if (response.statusCode == 200) {
        return Right(deletedClients);
      }
      return Left(AppFailure());
    } catch (e) {
      return Left(AppFailure());
    }
  }
}
