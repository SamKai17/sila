import 'dart:async';
import 'package:client/data/repositories/sync/sync_repository.dart';
import 'package:client/routing/router.dart';
import 'package:client/ui/auth/login/view_model/auth_viewmodel.dart';
import 'package:client/ui/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

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

  Future<void> sync() async {
    // print('syncing');
    // await _syncRepository.syncClients();
    // await _syncRepository.syncTransactions();
  }

  Future<void> periodicSyncing() async {
    Timer.periodic(
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
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer(
    retry: (retryCount, error) => null,
  );
  container.read(loginViewModel.notifier).getUser();

  SyncManager(
    syncRepository: container.read(syncRepository),
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sila',
      theme: AppTheme.darkThemeMode,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: ref.read(routerProvider),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(
            overscroll: false,
          ),
          child: child!,
        );
      },
    );
  }
}
