import 'package:client/routing/routes.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/ui/core/ui/clear_button.dart';
import 'package:client/ui/client/home/widgets/client_card.dart';
import 'package:client/ui/core/ui/delete_button.dart';
import 'package:client/ui/client/home/widgets/search_field.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(homeViewModel.notifier);
    final selectedMode = ref.watch(isClientSelectedMode);
    final clients = ref.watch(filteredClients(query));
    final selectedClientsNotifier = ref.read(selectedClients.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: 72,
        surfaceTintColor: AppPallete.background,
        titleSpacing: 32.0,
        title: !selectedMode
            ? Text(
                "Sila",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            : null,
        leadingWidth: 82,
        leading: selectedMode
            ? ClearButton(
                clear: selectedClientsNotifier.clearSelectedClients,
              )
            : null,
        actions: selectedMode
            ? [
                DeleteButton(delete: () {
                  viewModel.deleteClients();
                  selectedClientsNotifier.clearSelectedClients();
                }),
                SizedBox(width: 32)
              ]
            : null,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(72.0),
          child: SearchField(
            reload: (String q) {
              setState(() {
                query = q;
              });
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32.0,
            right: 32,
            bottom: 24.0,
          ),
          child: switch (clients) {
            AsyncValue(:final value?) => Column(
                spacing: 16.0,
                children: value.map(
                  (client) {
                    return ClientCard(
                      client: client,
                    );
                  },
                ).toList()),
            AsyncValue(error: != null) => const Text('error fetching clients'),
            AsyncValue() => LoaderWidget(),
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(Routes.clientCreateName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
