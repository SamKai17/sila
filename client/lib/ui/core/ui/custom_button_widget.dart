import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class CustomButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const CustomButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      onLongPress: () {},
      style: FilledButton.styleFrom(
        minimumSize: Size(double.infinity, 56.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(buttonText),
    );
  }
}
