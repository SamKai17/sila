import 'dart:async';
import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/utils/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final clientUpdateViewModel = AsyncNotifierProvider(ClientUpdateViewModel.new);

class ClientUpdateViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    _clientRepository = ref.read(clientRepository);
  }

  late ClientRepository _clientRepository;

  Future<void> updateClient({
    required String id,
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      state = AsyncValue.loading();
      final result = await _clientRepository.updateClient(
        id: id,
        name: name,
        phone: phone,
        city: city,
      );
      switch (result) {
        case Ok():
          state = AsyncValue.data(null);
        case Error():
          state = AsyncValue.error(result.error, StackTrace.current);
      }
    } finally {}
  }
}
