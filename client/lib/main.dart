import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/data/services/database_service.dart';
import 'package:client/routing/router.dart';
import 'package:client/ui/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    Provider(
      create: (context) => DatabaseService(),
    ),
    Provider(
      create: (context) => ClientRepository(databaseService: context.read()),
    ),
    // Provider(
    // create: (context) => ClientRepository(databaseService: context.read())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sila',
      theme: AppTheme.darkThemeMode,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
