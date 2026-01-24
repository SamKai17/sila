import 'package:client/core/providers/auth_local_repository.dart';
import 'package:client/features/client/model/client_model.dart';
import 'package:client/features/client/repositories/client_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:fpdart/fpdart.dart' as fp;

final clientProvider = AsyncNotifierProvider<ClientNotifier, List<ClientModel>>(
  ClientNotifier.new,
);

class ClientNotifier extends AsyncNotifier<List<ClientModel>> {
  late ClientRepository _clientRepository;
  late AuthLocalRepository _authLocalRepository;
  @override
  List<ClientModel> build() {
    _clientRepository = ref.watch(clientRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    return state.value ?? [];
  }

  Future<void> getAllClients() async {
    String? token = _authLocalRepository.getAccessToken();
    if (token != null) {
      state = AsyncValue.loading();
      final res = await _clientRepository.getAllClients(token);
      final _ = switch (res) {
        fp.Right(value: final r) => state = AsyncValue.data(r),
        fp.Left(value: final l) => state = AsyncValue.error(
          l,
          StackTrace.current,
        ),
      };
    }
  }
}
