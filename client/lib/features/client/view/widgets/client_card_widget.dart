import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/client/model/client_model.dart';
import 'package:client/features/client/view/pages/client_detail_page.dart';
import 'package:client/features/client/viewmodel/client_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientCardWidget extends ConsumerStatefulWidget {
  final ClientModel client;
  bool selectedMode;
  ClientCardWidget({
    super.key,
    required this.client,
    required this.selectedMode,
  });

  @override
  ConsumerState<ClientCardWidget> createState() => _ClientCardWidgetState();
}

class _ClientCardWidgetState extends ConsumerState<ClientCardWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        child: Card(
          color: isSelected == false ? AppPallete.surface : Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 18.0),
                Column(
                  children: [
                    Text(widget.client.name),
                    Text(widget.client.phone),
                  ],
                ),
                Spacer(),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        onLongPress: () {
          setState(() {
            isSelected = !isSelected;
            if (isSelected == true) {
              ref
                  .read(selectedClientsProvider.notifier)
                  .addClient(widget.client.id);
            } else {
              ref
                  .read(selectedClientsProvider.notifier)
                  .removeClient(widget.client.id);
            }
          });
          print("long pressed ${isSelected}");
        },
        onTap: () {
          if (!widget.selectedMode) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ClientDetailPage(clientId: widget.client.id);
                },
              ),
            );
          } else {
            setState(() {
              isSelected = !isSelected;
              if (isSelected == true) {
                ref
                    .read(selectedClientsProvider.notifier)
                    .addClient(widget.client.id);
              } else {
                ref
                    .read(selectedClientsProvider.notifier)
                    .removeClient(widget.client.id);
              }
            });
          }
        },
      ),
    );
  }
}
