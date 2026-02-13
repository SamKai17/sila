import 'package:client/routing/routes.dart';
import 'package:client/ui/client/create/widgets/client_create_screen.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/ui/client/home/widgets/clear_selected_clients_button.dart';
import 'package:client/ui/client/home/widgets/client_card.dart';
import 'package:client/ui/client/home/widgets/delete_clients_button.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sila"),
        leading: ClearSelectedClientsButton(
          clearSelectedClients: viewModel.clearSelectedClients,
        ),
        actions: [
          DeleteClientsButton(deleteClients: viewModel.deleteClients.execute),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListenableBuilder(
            listenable: viewModel.load,
            builder: (context, child) {
              if (viewModel.load.running) {
                return LoaderWidget();
              }
              if (viewModel.load.error) {
                return Center(child: Text("no clients found"));
              }
              return child!;
            },
            child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, child) {
                return ListView.builder(
                  itemCount: viewModel.clients.length,
                  itemBuilder: (context, index) {
                    final client = viewModel.clients[index];
                    return ClientCard(
                      client: client,
                      viewModel: viewModel,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(Routes.clientCreate);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
