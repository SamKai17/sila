import 'dart:convert';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/domain/models/auth/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

final authRemoteRepositoryProvider = Provider<AuthRemoteRepository>((ref) {
  return AuthRemoteRepository();
});

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverURL}/auth/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      if (response.statusCode != 200) {
        return Left(AppFailure(message: response.body));
      }
      final user = UserModel.fromJson(response.body);
      return Right(user);
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> register({
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverURL}/auth/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'confirm_password': confirmPassword,
        }),
      );
      if (response.statusCode != 201) {
        return Left(AppFailure(message: response.body));
      }
      return Right(UserModel.fromJson(response.body));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> getUserData(final String token) async {
    try {
      final response = await http.get(
        Uri.parse('${ServerConstant.serverURL}/auth/'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode != 200) {
        return Left(AppFailure(message: response.body));
      }
      final user = UserModel.fromJson(response.body);
      return Right(user);
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}
