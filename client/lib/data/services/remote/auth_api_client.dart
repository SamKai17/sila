import 'dart:convert';
import 'package:client/domain/models/auth/user.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final authApiClient = Provider(
  (ref) {
    return AuthApiClient();
  },
);

class AuthApiClient {
  Future<Result<User>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.uri}/auth/login/'),
        headers: {
          Constants.contentType: 'application/json',
        },
        body: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('an error while login');
      }
      final user =
          User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return Result.ok(user);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<User>> getUser({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.uri}/auth/'),
        headers: {
          Constants.authorization: 'Bearer ${accessToken}',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('an error while getting user data');
      }
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      final id = result['id'] as int;
      final username = result['username'] as String;
      final user = User(
        id: id,
        username: username,
        access: accessToken,
        refresh: refreshToken,
      );
      return Result.ok(user);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
