import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CloseButton extends StatelessWidget {
  const CloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppPallete.surface,
      ),
      child: IconButton(
        onPressed: () async {},
        icon: Icon(Icons.close),
      ),
    );
  }
}
