import 'dart:convert';

import 'package:client/utils/constants.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final apiClient = Provider(
  (ref) {
    return ApiClient();
  },
);

class ApiClient {
  Future<Result<void>> addClient({
    required String accessToken,
    required String id,
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.uri}/api/client/'),
        headers: {
          Constants.contentType: 'application/json',
          Constants.authorization: 'Bearer ${accessToken}'
        },
        body: jsonEncode(
          {
            'id': id,
            'name': name,
            'phone': phone,
            'city': city,
          },
        ),
      );
      // print(response.body);
      // print(response.statusCode);
      if (response.statusCode != 201) {
        throw Exception('error creating client');
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> updateClient({
    required String accessToken,
    required String id,
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      print('${Constants.uri}/api/client/${id}/');
      final response = await http.put(
        Uri.parse('${Constants.uri}/api/client/${id}/'),
        headers: {
          Constants.contentType: 'application/json',
          Constants.authorization: 'Bearer ${accessToken}'
        },
        body: jsonEncode(
          {
            'name': name,
            'phone': phone,
            'city': city,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('error updating client');
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteClients({
    required String accessToken,
    required List<String> ids,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.uri}/api/clients/delete/'),
        headers: {
          Constants.contentType: 'application/json',
          Constants.authorization: 'Bearer ${accessToken}'
        },
        body: jsonEncode(
          {
            'ids': ids,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('error creating client');
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
