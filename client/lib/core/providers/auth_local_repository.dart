import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authLocalRepositoryProvider = Provider<AuthLocalRepository>((ref) {
  return AuthLocalRepository();
});

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setAccessToken(String? token) async {
    if (token != null) {
      await _sharedPreferences.setString('access', token);
    }
  }

  Future<void> setRefreshToken(String? token) async {
    if (token != null) {
      await _sharedPreferences.setString('refresh', token);
    }
  }

  String? getAccessToken() {
    String? access = _sharedPreferences.getString('access');
    return access;
  }

  String? getRefreshToken() {
    String? access = _sharedPreferences.getString('refresh');
    return access;
  }

  Future<void> clearTokens() async {
    await _sharedPreferences.remove('access');
    await _sharedPreferences.remove('refresh');
  }
}
