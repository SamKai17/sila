import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/client/model/client_model.dart';
import 'package:client/features/client/view/pages/client_detail_page.dart';
import 'package:client/features/client/viewmodel/client_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientCardWidget extends ConsumerStatefulWidget {
  final ClientModel client;
  const ClientCardWidget({super.key, required this.client});

  @override
  ConsumerState<ClientCardWidget> createState() => _ClientCardWidgetState();
}

class _ClientCardWidgetState extends ConsumerState<ClientCardWidget> {
  @override
  Widget build(BuildContext context) {
    final selectedClients = ref.watch(selectedClientsProvider);
    final isSelected = selectedClients.contains(widget.client.id);
    bool selectedMode = selectedClients.isEmpty ? false : true;
    // print("clients: $selectedClients");
    // print("selectedItem: $isSelected");
    // print("mode: $selectedMode");
    return SizedBox(
      width: double.infinity,
      // height: 90.0,
      child: GestureDetector(
        child: Card(
          color: isSelected
              ? AppPallete.selectedBackground
              : AppPallete.surface,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 32.0,
                      backgroundColor: AppPallete.avatarBackground,
                      foregroundColor: AppPallete.primary,
                      child: Text(widget.client.name[0]),
                    ),
                    if (isSelected)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        // alignment: Alignment.bottomRight,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: AppPallete.primary,
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 15.0,
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(width: 18.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.client.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppPallete.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.client.phone,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppPallete.greyText,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        onLongPress: () {
          if (isSelected == false) {
            ref
                .read(selectedClientsProvider.notifier)
                .addClient(widget.client.id);
          } else {
            ref
                .read(selectedClientsProvider.notifier)
                .removeClient(widget.client.id);
          }
        },
        onTap: () {
          if (selectedMode == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ClientDetailPage(clientId: widget.client.id);
                },
              ),
            );
          } else {
            if (isSelected == false) {
              ref
                  .read(selectedClientsProvider.notifier)
                  .addClient(widget.client.id);
            } else {
              ref
                  .read(selectedClientsProvider.notifier)
                  .removeClient(widget.client.id);
            }
          }
        },
      ),
    );
  }
}
