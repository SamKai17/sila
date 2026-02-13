import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteClientsButton extends StatelessWidget {
  const DeleteClientsButton({super.key, required this.deleteClients});

  final Future<void> Function() deleteClients;

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
                            context.pop();
                          },
                          child: Text("Cancel"),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: FilledButton(
                          onPressed: () async {
                            await deleteClients();
                            context.pop();
                          },
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
