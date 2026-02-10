import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/data/repositories/auth/auth_remote_repository.dart';
import 'package:client/domain/models/auth/user_model.dart';
import 'package:client/core/providers/auth_local_repository.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:riverpod/riverpod.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, UserModel?>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<UserModel?> {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  UserModel? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserProvider.notifier);
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = AsyncValue.loading();
    final res = await _authRemoteRepository.login(
      username: username,
      password: password,
    );
    final _ = switch (res) {
      fp.Right(value: final r) => state = _authSuccess(r),
      fp.Left(value: final l) => state = AsyncValue.error(
        l,
        StackTrace.current,
      ),
    };
  }

  Future<void> register({
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    state = AsyncValue.loading();
    final res = await _authRemoteRepository.register(
      username: username,
      password: password,
      confirmPassword: confirmPassword,
    );
    final _ = switch (res) {
      fp.Right(value: final r) => _authSuccess(r),
      fp.Left(value: final l) => state = AsyncValue.error(
        l,
        StackTrace.current,
      ),
    };
  }

  AsyncValue<UserModel?> _authSuccess(UserModel user) {
    _authLocalRepository.setAccessToken(user.access);
    _authLocalRepository.setRefreshToken(user.refresh);
    _currentUserNotifier.setUser(user);
    return state = AsyncValue.data(user);
  }

  Future<void> getUserData() async {
    final accessToken = _authLocalRepository.getAccessToken();
    final refreshToken = _authLocalRepository.getRefreshToken();
    // print("token: $accessToken");
    if (accessToken != null) {
      state = AsyncValue.loading();
      final res = await _authRemoteRepository.getUserData(accessToken);
      final _ = switch (res) {
        fp.Right(value: final r) => _getUserDataSuccess(
          r.copyWith(access: accessToken, refresh: refreshToken),
        ),
        fp.Left(value: final l) => state = AsyncValue.error(
          l,
          StackTrace.current,
        ),
      };
    }
  }

  AsyncValue<UserModel?> _getUserDataSuccess(UserModel user) {
    _currentUserNotifier.setUser(user);
    return state = AsyncValue.data(user);
  }
}
