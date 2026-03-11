import 'dart:async';
import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/utils/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final clientCreateViewModel =
    AsyncNotifierProvider<ClientCreateViewModel, void>(
        ClientCreateViewModel.new);

class ClientCreateViewModel extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    _clientRepository = ref.read(clientRepository);
  }

  late ClientRepository _clientRepository;

  Future<void> addClient({
    required String name,
    required String city,
    required String phone,
  }) async {
    try {
      state = AsyncValue.loading();
      final result = await _clientRepository.addClient(
        name: name,
        city: city,
        phone: phone,
      );
      switch (result) {
        case Ok():
          state = AsyncValue.data(null);
        case Error():
          state = AsyncValue.error(result.error, StackTrace.current);
      }
    } finally {
      ref.invalidate(homeViewModel);
    }
  }
}
