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

  void setToken(String? token) {
    if (token != null) {
      _sharedPreferences.setString('access', token);
    }
  }

  String? getToken() {
    String? access = _sharedPreferences.getString('access');
    return access;
  }
}
