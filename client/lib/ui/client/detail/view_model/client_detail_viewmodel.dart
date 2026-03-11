import 'dart:async';
import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:client/utils/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final clientDetailViewModel = AsyncNotifierProvider.autoDispose.family<ClientDetailViewModel,Client, String>(ClientDetailViewModel.new);

class ClientDetailViewModel extends AsyncNotifier<Client> {
  ClientDetailViewModel(this.id);

  final String id;

  @override
  FutureOr<Client> build() {
    _clientRepository = ref.read(clientRepository);
    return load(id);
  }

  late ClientRepository _clientRepository;

  Future<Client> load(String id) async {
    try {
      final result = await _clientRepository.getClient(id);
      switch (result) {
        case Ok():
          return result.value;
        case Error():
          throw result.error;
      }
    } finally {}
  }
}