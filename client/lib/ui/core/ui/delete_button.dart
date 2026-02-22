import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.delete});

  final Function() delete;

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
                title: Center(child: Text("Delete these items?")),
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
                          onPressed: () {
                            delete();
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
