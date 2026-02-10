import 'package:client/ui/core/theme/app_theme.dart';
import 'package:client/ui/client/home/widgets/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sila',
      theme: AppTheme.darkThemeMode,
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
