import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class CustomFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  const CustomFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
      decoration: InputDecoration(hintText: hintText),
      obscureText: isObscureText,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
    );
  }
}
