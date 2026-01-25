import 'package:client/core/failure/failure.dart';
import 'package:client/core/providers/auth_local_repository.dart';
import 'package:client/features/client/model/client_model.dart';
import 'package:client/features/client/repositories/client_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:fpdart/fpdart.dart' as fp;

final clientProvider = Provider.autoDispose
    .family<AsyncValue<ClientModel?>, int>((ref, id) {
      final asyncClientList = ref.watch(clientListProvider);
      return asyncClientList.whenData((clientList) {
        final index = clientList.indexWhere((client) => client.id == id);
        return index != -1 ? clientList[index] : null;
      });
    });

final clientListProvider =
    AsyncNotifierProvider<ClientNotifier, List<ClientModel>>(
      ClientNotifier.new,
    );

class ClientNotifier extends AsyncNotifier<List<ClientModel>> {
  late ClientRepository _clientRepository;
  late AuthLocalRepository _authLocalRepository;

  @override
  Future<List<ClientModel>> build() async {
    _clientRepository = ref.watch(clientRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    return await getAllClients();
  }

  Future<List<ClientModel>> getAllClients() async {
    String? token = _authLocalRepository.getAccessToken();
    if (token != null) {
      final res = await _clientRepository.getAllClients(token);
      final result = switch (res) {
        fp.Right(value: final r) => r,
        fp.Left(value: final l) => throw l,
      };
      // print(result);
      return result;
    }
    throw AppFailure();
  }

  Future<void> addClient({String? name, String? phone, String? city}) async {
    String? token = _authLocalRepository.getAccessToken();
    if (token != null) {
      state = AsyncValue.loading();
      final res = await _clientRepository.addClient(
        token: token,
        name: name,
        phone: phone,
        city: city,
      );
      final _ = switch (res) {
        fp.Right(value: final r) => state = AsyncValue.data([
          ...(state.value ?? []),
          r,
        ]),
        fp.Left(value: final l) => state = AsyncValue.error(
          l,
          StackTrace.current,
        ),
      };
    }
    // error if no token is found -- to be determined
  }

  Future<void> updateClient({
    required int id,
    String? name,
    String? phone,
    String? city,
  }) async {
    String? token = _authLocalRepository.getAccessToken();
    if (token != null) {
      state = AsyncValue.loading();
      final res = await _clientRepository.updateClient(
        token: token,
        id: id,
        name: name,
        phone: phone,
        city: city,
      );
      final _ = switch (res) {
        fp.Right(value: final r) => updateClientSuccess(r),
        fp.Left(value: final l) => state = AsyncValue.error(
          l,
          StackTrace.current,
        ),
      };
    }
    // error
  }

  void updateClientSuccess(ClientModel newClient) {
    final oldList = state.value ?? [];
    final newList = oldList.map((client) {
      if (client.id == newClient.id) {
        return newClient;
      }
      return client;
    }).toList();
    state = AsyncValue.data(newList);
  }
}
