import 'dart:async';
import 'package:client/data/repositories/sync/sync_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final syncManager = Provider(
  (ref) {
    return SyncManager(syncRepository: ref.read(syncRepository));
  },
);

class SyncManager {
  SyncManager({
    required SyncRepository syncRepository,
  }) : _syncRepository = syncRepository {
    _subscription = InternetConnection().onStatusChange.listen(
      (InternetStatus status) async {
        if (status == InternetStatus.connected) {
          print('internet is connected');
          await sync();
          // Internet is connected
        } else {
          print('internet is disconnected');
          // Internet is disconnected
        }
      },
    );
    periodicSyncing();
  }

  late StreamSubscription<InternetStatus> _subscription;
  late SyncRepository _syncRepository;
  Timer? _timer;

  Future<void> sync() async {
    // print('syncing');
    // await _syncRepository.syncClientsToRemote();
    // await _syncRepository.syncTransactionsToRemote();
  }

  Future<void> periodicSyncing() async {
    _timer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) async {
        // check if internet is available
        // print('periodic');
        await sync();
      },
    );
  }

  Future<void> cancel() async {
    await _subscription.cancel();
    if (_timer != null) {
      _timer!.cancel();
    }
  }
}
