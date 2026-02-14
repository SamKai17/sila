import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ClearSelectedClientsButton extends StatelessWidget {
  const ClearSelectedClientsButton(
      {super.key, required this.clearSelectedClients});

  final Function clearSelectedClients;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
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
              clearSelectedClients();
            },
            icon: Icon(Icons.close),
          ),
        ),
      ),
    );
  }
}
