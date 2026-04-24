import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({super.key, required this.clear});

  final Function clear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 32.0),
      child: UnconstrainedBox(
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppPallete.surface,
          ),
          child: IconButton(
            onPressed: () async {
              clear();
            },
            icon: Icon(Icons.close),
          ),
        ),
      ),
    );
  }
}
