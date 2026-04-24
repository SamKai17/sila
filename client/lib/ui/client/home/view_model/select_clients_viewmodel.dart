import 'package:client/domain/models/client/client.dart';
import 'package:riverpod/riverpod.dart';

final selectClientsViewModel =
    NotifierProvider<SelectClientsViewModel, List<Client>>(
        SelectClientsViewModel.new);

class SelectClientsViewModel extends Notifier<List<Client>> {
  @override
  List<Client> build() {
    return [];
  }

  bool isClientSelected(Client client) {
    return state.contains(client);
  }

  void addClient(Client client) {
    state = [...state, client];
  }

  void removeClient(Client client) {
    final newList = [...state];
    newList.remove(client);
    state = newList;
  }

  void clear() {
    state = [];
  }
}
