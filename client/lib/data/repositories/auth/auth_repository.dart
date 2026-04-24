import 'dart:async';

import 'package:client/data/services/local/secure_storage_service.dart';
import 'package:client/data/services/remote/auth_api_client.dart';
import 'package:client/domain/models/auth/user.dart';
import 'package:client/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepository = Provider(
  (ref) {
    return AuthRepository(
      authApiClient: ref.read(authApiClient),
      secureStorageService: ref.read(secureStorageService),
    );
  },
);

class AuthRepository {
  AuthRepository({
    required AuthApiClient authApiClient,
    required SecureStorageService secureStorageService,
  })  : _authApiClient = authApiClient,
        _secureStorageService = secureStorageService;

  final AuthApiClient _authApiClient;
  final SecureStorageService _secureStorageService;

  Stream<Result<String>> get observeCode => _authApiClient.observeCode;
  Future<Result<void>> login({
    required String smsCode,
  }) async {
    return _authApiClient.login(
      smsCode: smsCode,
    );
  }

  Future<void> sendCode({required String phoneNumber}) async {
    await _authApiClient.sendCode(phoneNumber: phoneNumber);
  }

  Future<Result<void>> logout() async {
    return _authApiClient.logout();
  }

  // Future<Result<void>> register({
  //   required String username,
  //   required String password,
  //   required String confirmPassword,
  // }) async {
  //   final result = await _authApiClient.register(
  //     username: username,
  //     password: password,
  //     confirmPassword: confirmPassword,
  //   );
  //   return result;
  // }

  // Future<void> setTokens({required User? user}) async {
  //   if (user != null) {
  //     await _secureStorageService.setTokens(
  //       (
  //         accessToken: user.access,
  //         refreshToken: user.refresh,
  //       ),
  //     );
  //   }
  // }

  // Future<void> clearTokens() async {
  //   await _secureStorageService.clearTokens();
  // }

  // Future<Result<User>> getUser() async {
  //   final tokenPair = await _secureStorageService.getTokens();
  //   if (tokenPair != null) {
  //     return await _authApiClient.getUser(
  //       accessToken: tokenPair.accessToken,
  //       refreshToken: tokenPair.refreshToken,
  //     );
  //   }
  //   return Result.error(Exception('no token found'));
  // }

  // Future<void> register({
  //   required String username,
  //   required String password,
  //   required String confirmPassword,
  // }) async {}
}
