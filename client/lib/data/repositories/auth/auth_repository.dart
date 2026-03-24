import 'package:client/data/services/local/secure_storage_service.dart';
import 'package:client/data/services/local/shared_preferences_service.dart';
import 'package:client/data/services/remote/auth_api_client.dart';
import 'package:client/domain/models/auth/user.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepository = Provider(
  (ref) {
    return AuthRepository(
      authApiClient: ref.read(authApiClient),
      prefs: ref.read(sharedPreferencesService),
      secureStorageService: ref.read(secureStorageService),
    );
  },
);

class AuthRepository {
  AuthRepository({
    required AuthApiClient authApiClient,
    required SharedPreferencesService prefs,
    required SecureStorageService secureStorageService,
  })  : _authApiClient = authApiClient,
        _prefs = prefs,
        _secureStorageService = secureStorageService;

  final AuthApiClient _authApiClient;
  final SharedPreferencesService _prefs;
  final SecureStorageService _secureStorageService;

  Future<Result<User?>> login({
    required String username,
    required String password,
  }) async {
    final result =
        await _authApiClient.login(username: username, password: password);
    return result;
  }

  Future<void> setTokens({required User? user}) async {
    if (!_prefs.isOpen) {
      await _prefs.open();
    }
    if (user != null) {
      await _prefs.setTokens(access: user.access, refresh: user.refresh);
      await _secureStorageService.setTokens((
        accessToken: user.access,
        refreshToken: user.refresh,
      ));
    }
  }

  Future<void> clearTokens() async {
    if (!_prefs.isOpen) {
      await _prefs.open();
    }
    await _prefs.clearTokens();
  }

  Future<Result<User>> getUser() async {
    if (!_prefs.isOpen) {
      await _prefs.open();
    }
    final accessToken = _prefs.getAccessToken();
    final refreshToken = _prefs.getRefreshToken();
    if (accessToken == null || refreshToken == null) {
      return Result.error(Exception('lack of tokens'));
    }
    return await _authApiClient.getUser(
        accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<Result<void>> refreshAccess() async {
    if (!_prefs.isOpen) {
      await _prefs.open();
    }
    final refreshToken = _prefs.getRefreshToken();
    if (refreshToken != null) {
      final result =
          await _authApiClient.refreshAccess(refreshToken: refreshToken);
      return result;
    }
    return Result.error(Exception('refresh token not found'));
  }

  Future<void> register({
    required String username,
    required String password,
    required String confirmPassword,
  }) async {}
}
