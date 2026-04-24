import 'dart:async';
import 'package:client/data/repositories/sync/sync_repository.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:client/routing/router.dart';
import 'package:client/ui/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logging/logging.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer(
    retry: (retryCount, error) => null,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.loggerName}: ${record.message}');
  });

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
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.helloWorld,
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
