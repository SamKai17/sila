import 'package:client/l10n/app_localizations.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/auth/logout/widgets/logout_button.dart';
import 'package:client/ui/client/delete/view_model/delete_clients_viewmodel.dart';
import 'package:client/ui/client/home/view_model/select_clients_viewmodel.dart';
import 'package:client/ui/client/home/view_model/search_clients_viewmodel.dart';
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
    final selectedMode = ref.watch(selectClientsViewModel).isNotEmpty;
    final clients = ref.watch(searchedClientsProvider);
    final isLoading =
        clients.isLoading || ref.watch(deleteClientsViewModel).isLoading;

    ref.listen(
      searchedClientsProvider,
      (previous, next) {
        next.when(
          data: (data) {},
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('an error happened')));
          },
          loading: () {},
        );
      },
    );

    ref.listen(
      deleteClientsViewModel,
      (previous, next) {
        next.when(
          data: (data) {},
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('an error happened')));
          },
          loading: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: 72,
        surfaceTintColor: AppPallete.background,
        titleSpacing: 32.0,
        title: !selectedMode
            ? Text(
                AppLocalizations.of(context)!.appTitle,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            : null,
        leadingWidth: 82,
        leading: selectedMode
            ? ClearButton(
                clear: ref.read(selectClientsViewModel.notifier).clear,
              )
            : null,
        actions: selectedMode
            ? [
                DeleteButton(
                  delete: () {
                    ref.read(deleteClientsViewModel.notifier).deleteClients(
                          clients: ref.read(selectClientsViewModel),
                        );
                    ref.read(selectClientsViewModel.notifier).clear();
                  },
                ),
                SizedBox(width: 32)
              ]
            : [
                LogoutButton(),
                SizedBox(width: 32),
              ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(72.0),
          child: SearchField(
            reload: (String q) {
              setState(() {
                ref.read(searchQueryProvider.notifier).addQuery(q);
              });
            },
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: LoaderWidget(),
            )
          : clients.when(
              data: (data) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 12.0,
                    );
                  },
                  itemBuilder: (context, index) {
                    final client = data[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                      child: ClientCard(
                        key: Key(client.id),
                        client: client,
                      ),
                    );
                  },
                  itemCount: data.length,
                );
              },
              error: (error, stackTrace) {
                return Center(
                  child: Text('couldn\'t fetch client'),
                );
              },
              loading: () {
                return Center(
                  child: LoaderWidget(),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(Routes.clientCreateName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
