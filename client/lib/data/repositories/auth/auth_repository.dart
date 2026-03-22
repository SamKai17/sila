
import 'package:client/data/services/remote/auth_api_client.dart';
import 'package:client/domain/models/auth/user.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepository = Provider((ref) {
  return AuthRepository(ref.read(authApiClient));
},);

class AuthRepository {
  AuthRepository(this._authApiClient);

  final AuthApiClient _authApiClient;

  Future<Result<User?>> login({
    required String username,
    required String password,
  }) async {
    final result = await _authApiClient.login(username: username, password: password);
    return result;
  }

  Future<void> register({
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
  
  }
}
