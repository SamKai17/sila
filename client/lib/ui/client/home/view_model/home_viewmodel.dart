import 'dart:async';
import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';
import 'package:riverpod/riverpod.dart';

final deleteClientsViewModel =
    AsyncNotifierProvider<DeleteClientsViewModel, void>(
        DeleteClientsViewModel.new);

class DeleteClientsViewModel extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    _clientRepository = ref.read(clientRepository);
  }

  late ClientRepository _clientRepository;

  Future<void> deleteClients() async {
    try {
      state = AsyncValue.loading();
      final selectedClientsList = ref.read(selectedClients);
      final ids = selectedClientsList.map((client) => client.id).toList();
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

final isClientSelected = Provider.family(
  (ref, Client client) {
    final _selectedClients = ref.watch(selectedClients);
    return _selectedClients.contains(client);
  },
);

final clientsSelectedMode = Provider(
  (ref) {
    final _selectedClients = ref.watch(selectedClients);
    return _selectedClients.isNotEmpty;
  },
);

final queryProvider = NotifierProvider<Querying, String>(Querying.new);

class Querying extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void addQuery(String newQuery) {
    state = newQuery;
  }
}

final filteredClients = Provider<AsyncValue<List<Client>>>(
  (ref) {
    final clientsList = ref.watch(clientsProvider);
    final _query = ref.watch(queryProvider);

    return clientsList.whenData(
      (value) {
        return value.where((client) => client.name.contains(_query)).toList();
      },
    );
  },
);

final selectedClients =
    NotifierProvider<SelectedClients, List<Client>>(SelectedClients.new);

class SelectedClients extends Notifier<List<Client>> {
  @override
  List<Client> build() {
    return [];
  }

  void addSelectedClient(Client client) {
    state = [...state, client];
  }

  void removeSelectedClient(Client client) {
    final newList = [...state];
    newList.remove(client);
    state = newList;
  }

  void clearSelectedClients() {
    state = [];
  }
}
