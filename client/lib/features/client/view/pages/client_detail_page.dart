import 'package:client/core/theme/app_pallete.dart';
// import 'package:client/core/widgets/custom_button_widget.dart';
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
                        return ClientUpdatePage(client: client);
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
            child: SizedBox(
              // color: Colors.amber,
              width: double.infinity,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: AppPallete.avatarBackground,
                    foregroundColor: AppPallete.primary,
                    child: Text(client.name[0]),
                  ),
                  Text(
                    client.name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    client.city,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppPallete.greyText,
                    ),
                  ),
                  Text(
                    client.phone,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppPallete.greyText,
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    height: 70.0,
                    width: 70.0,
                    child: Card(child: Icon(Icons.swap_horiz)),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          child: Text('Buy'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          child: Text('Sell'),
                        ),
                      ),
                    ],
                  ),
                  // CustomButtonWidget(buttonText: 'Buy', onPressed: () {}),
                  // CustomButtonWidget(buttonText: 'Sell', onPressed: () {}),
                ],
              ),
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
