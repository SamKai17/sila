import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme _buildTextTheme() {
    final base = ThemeData.dark().textTheme;
    final poppinsBase = GoogleFonts.poppinsTextTheme(base);
    return poppinsBase.copyWith(
      headlineLarge: poppinsBase.headlineLarge?.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
      // bodyLarge: poppinsBase.bodyLarge?.copyWith(
      //   fontSize: 20,
      //   fontWeight: FontWeight.w900,
      // ),
    );
  }

  static OutlineInputBorder _border(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 2),
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.background,
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.background),
    colorScheme: ColorScheme.dark(
      primary: AppPallete.primary,
      surface: AppPallete.surface,
      onPrimary: AppPallete.onPrimary,
      // secondary: AppPallete.secondary,
    ),
    textTheme: _buildTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: AppPallete.border,
        fontStyle: FontStyle.italic,
      ),
      contentPadding: EdgeInsets.all(20.0),
      enabledBorder: _border(AppPallete.border),
      focusedBorder: _border(AppPallete.primary),
    ),
  );
}
