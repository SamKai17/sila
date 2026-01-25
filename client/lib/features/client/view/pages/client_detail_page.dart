import 'package:client/core/widgets/custom_button_widget.dart';
import 'package:client/core/widgets/loader_widget.dart';
import 'package:client/features/client/view/pages/client_update_page.dart';
import 'package:client/features/client/viewmodel/client_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientDetailPage extends ConsumerWidget {
  final int clientId;
  const ClientDetailPage({super.key, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncClient = ref.watch(clientProvider(clientId));
    return asyncClient.when(
      data: (client) {
        if (client == null) {
          return Scaffold(body: Center(child: Text("client not found")));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("client"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ClientUpdatePage(client: client!);
                      },
                    ),
                  );
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CircleAvatar(radius: 50.0),
                Text(client.name),
                Text(client.city),
                Text(client.phone),
                SizedBox(height: 32),
                SizedBox(
                  height: 70.0,
                  width: 70.0,
                  child: Card(child: Icon(Icons.swap_horiz)),
                ),
                SizedBox(height: 32),
                CustomButtonWidget(buttonText: 'Buy', onPressed: () {}),
                SizedBox(height: 32),
                CustomButtonWidget(buttonText: 'Sell', onPressed: () {}),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(body: Center(child: Text("error happened!")));
      },
      loading: () {
        return Scaffold(body: LoaderWidget());
      },
    );
  }
}
