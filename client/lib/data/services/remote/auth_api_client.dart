import 'package:client/domain/models/auth/user.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authApiClient = Provider(
  (ref) {
    final options = BaseOptions(baseUrl: Constants.uri);
    return AuthApiClient(dio: Dio(options));
  },
);

class AuthApiClient {
  AuthApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<Result<User>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login/',
        data: {
          'username': username,
          'password': password,
        },
      );
      final user = User.fromJson(response.data as Map<String, dynamic>);
      return Result.ok(user);
    } on DioException catch (e) {
      if (e.response != null) {
        // server error
        print('exception: ${e.response!.statusCode}');
      } else {
        print('my error');
        // your error
      }
      return Result.error(e);
    }
  }

  Future<Result<User>> getUser({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      final response = await _dio.get(
        '/auth/',
        options: Options(
          headers: {
            Constants.authorization: 'Bearer ${accessToken}',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('an error while getting user data');
      }
      final result = response.data as Map<String, dynamic>;
      final id = result['id'] as int;
      final username = result['username'] as String;
      final user = User(
        id: id,
        username: username,
        access: accessToken,
        refresh: refreshToken,
      );
      return Result.ok(user);
    } on DioException catch (e) {
      return Result.error(e);
    }
  }
}
