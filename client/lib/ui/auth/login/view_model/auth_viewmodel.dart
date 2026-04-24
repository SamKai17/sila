import 'dart:async';
import 'package:client/data/repositories/auth/auth_repository.dart';
import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/data/repositories/sync/sync_repository.dart';
import 'package:client/data/services/remote/auth_api_client.dart';
import 'package:client/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(final Stream<dynamic> stream) {
    _subscription = stream.listen(
      (event) {
        notifyListeners();
      },
    );
  }

  late StreamSubscription<dynamic> _subscription;

  @override
  void dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}

final authViewModel =
    AsyncNotifierProvider<AuthViewModel, void>(AuthViewModel.new);

class AuthViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    _authRepository = ref.read(authRepository);
    _syncRepository = ref.read(syncRepository);
    _clientRepository = ref.read(clientRepository);
    final test = ref.watch(sendCodeNotification);
    test.when(
      data: (data) {
        print('data is ready');
        state = AsyncValue.data(null);
      },
      error: (error, stackTrace) {
        print('error is ready');
        state = AsyncValue.error(error, StackTrace.current);
      },
      loading: () {},
    );
    // ref.listen(
    //   sendCodeNotification,
    //   (previous, next) {
    //     next.when(
    //       data: (data) {
    //         print('code received');
    //         return null;
    //       },
    //       error: (error, stackTrace) {
    //         print('code errorrr received');
    //         throw error;
    //       },
    //       loading: () {},
    //     );
    //   },
    // );
    return null;
  }

  late AuthRepository _authRepository;
  late SyncRepository _syncRepository;
  late ClientRepository _clientRepository;
  late String _verificationId;

  Future<void> login({
    required String smsCode,
  }) async {
    state = AsyncValue.loading();
    final result = await _authRepository.login(
      smsCode: smsCode,
    );
    switch (result) {
      case Ok():
        // await _syncRepository.syncClientsToLocal();
        // await _clientRepository.syncClientsToLocal();
        state = AsyncValue.data(null);
      case Error():
        state = AsyncValue.error(result.error, StackTrace.current);
    }
  }

  Future<void> sendCode({required String phoneNumber}) async {
    // state = AsyncValue.loading();
    await _authRepository.sendCode(phoneNumber: phoneNumber);

    // switch (result) {
    // case Ok():
    // state = AsyncValue.data(null);
    // case Error():
    // state = AsyncValue.error(result.error, StackTrace.current);
    // }
  }

  Future<void> logout() async {
    state = AsyncValue.loading();
    final result = await _authRepository.logout();
    switch (result) {
      case Ok():
        state = AsyncValue.data(null);
      case Error():
        state = AsyncValue.error(result.error, StackTrace.current);
    }
  }
}
