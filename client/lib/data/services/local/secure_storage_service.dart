import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';

final secureStorageService = Provider(
  (ref) {
    return SecureStorageService();
  },
);

typedef TokenPair = ({String accessToken, String refreshToken});

class SecureStorageService {
  SecureStorageService() {
    _secureStorage = FlutterSecureStorage();
  }
  late FlutterSecureStorage _secureStorage;

  Future<String?> get accessToken => _secureStorage.read(key: 'accessToken');
  Future<String?> get refreshToken => _secureStorage.read(key: 'refreshToken');

  Future<TokenPair?> getTokens() async {
    final accessToken = await _secureStorage.read(key: 'accessToken');
    final refreshToken = await _secureStorage.read(key: 'refreshToken');
    if (accessToken != null && refreshToken != null) {
      return (accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  Future<void> setTokens(TokenPair tokenPair) async {
    await _secureStorage.write(
        key: 'accessToken', value: tokenPair.accessToken);
    await _secureStorage.write(
        key: 'refreshToken', value: tokenPair.refreshToken);
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');
  }
}
