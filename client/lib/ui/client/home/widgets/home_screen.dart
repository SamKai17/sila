import 'package:client/routing/routes.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/ui/client/home/widgets/clear_selected_clients_button.dart';
import 'package:client/ui/client/home/widgets/client_card.dart';
import 'package:client/ui/client/home/widgets/delete_clients_button.dart';
import 'package:client/ui/client/home/widgets/search_field.dart';
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
        title: Text(
          "Sila",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        leadingWidth: 82,
        leading: ClearSelectedClientsButton(
          clearSelectedClients: viewModel.clearSelectedClients,
        ),
        actions: [
          // if (viewModel.selectedMode)
          DeleteClientsButton(deleteClients: viewModel.deleteClients.execute),
          SizedBox(width: 32)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 32.0, right: 32, top: 24.0),
        child: Column(children: [
          SearchField(filter: viewModel.filter),
          SizedBox(height: 32.0),
          Expanded(
            child: SizedBox(
              width: double.infinity,
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
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 24.0),
                      itemCount: viewModel.filteredClients.length,
                      itemBuilder: (context, index) {
                        final client = viewModel.filteredClients[index];
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
        ]),
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
