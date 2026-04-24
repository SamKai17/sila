import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
    SearchQueryNotifier.new);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void addQuery(String newQuery) {
    state = newQuery;
  }
}

final searchedClientsProvider = Provider<AsyncValue<List<Client>>>(
  (ref) {
    final clientsList = ref.watch(clientsProvider);
    final query = ref.watch(searchQueryProvider);

    return clientsList.whenData(
      (value) {
        return value.where((client) => client.name.contains(query)).toList();
      },
    );
  },
);
