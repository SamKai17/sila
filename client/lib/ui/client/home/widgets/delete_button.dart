import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

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
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Center(child: Text("Delete this client?")),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: FilledButton(
                          onPressed: () async {},
                          child: Text("Confirm"),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        icon: Icon(Icons.delete),
      ),
    );
  }
}
