import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class CustomNumberFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  const CustomNumberFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${hintText[0].toUpperCase()}${hintText.substring(1)}'),
        TextFormField(
          keyboardType: TextInputType.numberWithOptions(),
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
          obscureText: isObscureText,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "$hintText is missing";
            }
            return null;
          },
        ),
      ],
    );
  }
}
