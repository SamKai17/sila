import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:riverpod/riverpod.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthViewmodel, UserModel?>(
  AuthViewmodel.new,
);

class AuthViewmodel extends AsyncNotifier<UserModel?> {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  @override
  UserModel? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
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
    final val = switch (res) {
      fp.Right(value: final r) => state = AsyncValue.data(r),
      fp.Left(value: final l) => state = AsyncValue.error(
        l,
        StackTrace.current,
      ),
    };
  }

  Future<void> register({
    required String username,
    required String password,
  }) async {
    state = AsyncValue.loading();
    final res = await _authRemoteRepository.register(
      username: username,
      password: password,
    );
    final val = switch (res) {
      fp.Right(value: final r) => _loginSuccess(r),
      fp.Left(value: final l) => state = AsyncValue.error(
        l,
        StackTrace.current,
      ),
    };
  }

  AsyncValue<UserModel?> _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(user.access);
    return state = AsyncValue.data(user);
  }
}
