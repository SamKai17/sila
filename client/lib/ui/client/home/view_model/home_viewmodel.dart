import 'dart:async';
import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';
import 'package:riverpod/riverpod.dart';

final homeViewModel =
    AsyncNotifierProvider<HomeViewModel, List<Client>>(HomeViewModel.new);

final isClientSelected = Provider.family(
  (ref, Client client) {
    final _selectedClients = ref.watch(selectedClients);
    return _selectedClients.contains(client);
  },
);

final isClientSelectedMode = Provider(
  (ref) {
    final _selectedClients = ref.watch(selectedClients);
    return _selectedClients.isNotEmpty;
  },
);

final filteredClients = Provider.family<AsyncValue<List<Client>>, String>(
  (ref, String query) {
    final clientsList = ref.watch(homeViewModel);
    return clientsList.whenData(
      (value) {
        return value.where((client) => client.name.contains(query)).toList();
      },
    );
  },
);

final selectedClients = NotifierProvider<SelectedClients, List<Client>>(
  () {
    return SelectedClients();
  },
);

class SelectedClients extends Notifier<List<Client>> {
  @override
  List<Client> build() {
    return [];
  }

  void addSelectedClient(Client client) {
    // print('adding');
    state = [...state, client];
    print(state);
  }

  void removeSelectedClient(Client client) {
    // print('removing');
    final newList = [...state];
    newList.remove(client);
    state = newList;
  }

  void clearSelectedClients() {
    state = [];
  }
}

class HomeViewModel extends AsyncNotifier<List<Client>> {
  @override
  Future<List<Client>> build() {
    _clientRepository = ref.read(clientRepository);
    return load();
  }

  late ClientRepository _clientRepository;

  // List<Client> _filteredClients = [];

  // UnmodifiableListView<Client> get filteredClients =>
  //     UnmodifiableListView(_filteredClients);

  Future<List<Client>> load() async {
    final result = await _clientRepository.getClientsList();
    switch (result) {
      case Ok():
        return result.value;
      case Error():
        throw result.error;
    }
  }

  Future<void> deleteClients() async {
    try {
      state = AsyncValue.loading();
      final selectedClientsList = ref.read(selectedClients);
      final ids = selectedClientsList.map((client) => client.id).toList();
      final result = await _clientRepository.deleteClients(ids: ids);
      switch (result) {
        case Ok():
          ref.invalidateSelf();
        case Error():
          state = AsyncValue.error(result.error, StackTrace.current);
      }
    } finally {}
  }

  void filter(String query) {
    // _filteredClients =
    //     _clients.where((client) => client.name.contains(query)).toList();
    // notifyListeners();
  }
}
