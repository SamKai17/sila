import 'package:client/routing/routes.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/ui/client/home/widgets/clear_selected_clients_button.dart';
import 'package:client/ui/client/home/widgets/client_card.dart';
import 'package:client/ui/client/home/widgets/delete_clients_button.dart';
import 'package:client/ui/client/home/widgets/search_field.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("init home...");
      widget.viewModel.load.execute();
    });
    super.initState();
  }

  @override
  void dispose() {
    // print("home: we disposing");
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 72,
            surfaceTintColor: AppPallete.background,
            // backgroundColor: AppPallete.avatarBackground,
            titleSpacing: 32.0,
            title: !widget.viewModel.selectedMode
                ? Text(
                    "Sila",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : null,
            leadingWidth: 82,
            leading: widget.viewModel.selectedMode
                ? ClearSelectedClientsButton(
                    clearSelectedClients: widget.viewModel.clearSelectedClients,
                  )
                : null,
            actions: widget.viewModel.selectedMode
                ? [
                    DeleteClientsButton(
                        deleteClients: widget.viewModel.deleteClients.execute),
                    SizedBox(width: 32)
                  ]
                : null,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(72.0),
              child: SearchField(filter: widget.viewModel.filter),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                right: 32,
                // top: 24.0,
                bottom: 24.0,
              ),
              child: Column(children: [
                // SizedBox(height: 32.0),
                ListenableBuilder(
                  listenable: widget.viewModel.load,
                  builder: (context, child) {
                    if (widget.viewModel.load.running) {
                      return LoaderWidget();
                    }
                    if (widget.viewModel.load.error) {
                      return Center(child: Text("no clients found"));
                    }
                    return child!;
                  },
                  child: ListenableBuilder(
                    listenable: widget.viewModel,
                    builder: (context, child) {
                      final clients = widget.viewModel.filteredClients;
                      return Column(
                        spacing: 16.0,
                        children: clients.map(
                          (client) {
                            return ClientCard(
                              client: client,
                              viewModel: widget.viewModel,
                            );
                          },
                        ).toList(),
                      );
                    },
                  ),
                ),
                // ),
              ]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go("/${Routes.clientCreate}");
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
