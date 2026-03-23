import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesService = Provider(
  (ref) {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    return SharedPreferencesService();
  },
);

class SharedPreferencesService {
  SharedPreferencesService();
  SharedPreferences? _prefs;
  bool get isOpen => _prefs != null;

  Future<void> open() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setTokens({
    required String access,
    required String refresh,
  }) async {
    await _prefs!.setString('access', access);
    await _prefs!.setString('refresh', refresh);
    print('just set tokens');
  }

  String? getAccessToken() {
    return _prefs!.getString('access');
  }

  String? getRefreshToken() {
    return _prefs!.getString('refresh');
  }

  Future<void> clearTokens() async {
    print('cleared tokens');
    await _prefs!.clear();
  }
}
