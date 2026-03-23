import 'dart:async';
import 'package:client/data/repositories/auth/auth_repository.dart';
import 'package:client/domain/models/auth/user.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUser = Provider(
  (ref) {
    final userAsync = ref.read(loginViewModel);
    final notifier = AsyncValueNotifier(userAsync);
    ref.listen(
      loginViewModel,
      (previous, next) {
        notifier.update(next);
      },
    );
    return notifier;
  },
);

class AsyncValueNotifier<T> extends ChangeNotifier {
  AsyncValueNotifier(this._value);

  AsyncValue<T> _value;
  AsyncValue<T> get value => _value;

  void update(AsyncValue<T> newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }
}

final loginViewModel =
    AsyncNotifierProvider<LoginViewModel, User?>(LoginViewModel.new);

class LoginViewModel extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() {
    _authRepository = ref.read(authRepository);
    return null;
  }

  late AuthRepository _authRepository;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = AsyncValue.loading();
    final result =
        await _authRepository.login(username: username, password: password);
    switch (result) {
      case Ok():
        await _authRepository.setTokens(user: result.value);
        state = AsyncValue.data(result.value);
      case Error():
        state = AsyncValue.error(result.error, StackTrace.current);
    }
  }

  Future<void> logout() async {
    state = AsyncValue.data(null);
    await _authRepository.clearTokens();
  }

  Future<void> getUser() async {
    state = AsyncValue.loading();
    final result = await _authRepository.getUser();
    switch (result) {
      case Ok():
        state = AsyncValue.data(result.value);
      case Error():
        state = AsyncValue.error(result.error, StackTrace.current);
    }
  }
}
