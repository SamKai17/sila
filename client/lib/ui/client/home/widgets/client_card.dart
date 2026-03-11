import 'package:client/domain/models/client/client.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ClientCard extends ConsumerWidget {
  const ClientCard({
    super.key,
    required this.client,
  });

  final Client client;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(isClientSelected(client));
    final selectedMode = ref.watch(isClientSelectedMode);
    final selectedClientsNotifier = ref.read(selectedClients.notifier);

    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        child: Card(
          color:
              isSelected ? AppPallete.selectedBackground : AppPallete.surface,
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
                      child: Text(client.name[0].toUpperCase()),
                    ),
                    if (isSelected)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: AppPallete.primary,
                            shape: BoxShape.circle,
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
                      client.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppPallete.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      client.phone,
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
          print("on long pressed");
          if (isSelected) {
            selectedClientsNotifier.removeSelectedClient(client);
          } else {
            selectedClientsNotifier.addSelectedClient(client);
          }
        },
        onTap: () {
          if (!selectedMode) {
            // context.goNamed(
            //   Routes.clientDetailName,
            //   pathParameters: {'clientId': client.id},
            // );
          } else {
            if (isSelected) {
              selectedClientsNotifier.removeSelectedClient(client);
            } else {
              selectedClientsNotifier.addSelectedClient(client);
            }
          }
        },
      ),
    );
  }
}
