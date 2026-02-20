import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/data/services/database_service.dart';
import 'package:client/routing/router.dart';
import 'package:client/ui/client/create/view_model/client_create_viewmodel.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/ui/client/update/view_model/client_update_viewmodel.dart';
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
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(clientRepository: context.read()),
    ),
    ChangeNotifierProvider(
      create: (context) =>
          ClientDetailViewModel(clientRepository: context.read()),
    ),
    ChangeNotifierProvider(
      create: (context) =>
          ClientUpdateViewModel(clientRepository: context.read()),
    ),
    ChangeNotifierProvider(
      create: (context) =>
          ClientCreateViewModel(clientRepository: context.read()),
    )
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
