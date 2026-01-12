import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthButtonWidget({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: Size(double.infinity, 56.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.poppins(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text(buttonText),
    );
  }
}
