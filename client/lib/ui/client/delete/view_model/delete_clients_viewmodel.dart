import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteClientsViewModel =
    AsyncNotifierProvider<DeleteClientsViewModel, void>(
        DeleteClientsViewModel.new);

class DeleteClientsViewModel extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  ClientRepository get _clientRepository => ref.read(clientRepository);

  Future<void> deleteClients({required List<Client> clients}) async {
    try {
      state = AsyncValue.loading();
      final ids = clients.map((client) => client.id).toList();
      final result = await _clientRepository.deleteClients(ids: ids);
      switch (result) {
        case Ok():
          state = AsyncValue.data(null);
        case Error():
          state = AsyncValue.error(result.error, StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
