import 'package:client/routing/routes.dart';
import 'package:client/ui/auth/login/view_model/auth_viewmodel.dart';
import 'package:client/ui/auth/logout/widgets/logout_button.dart';
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
    final selectedMode = ref.watch(clientsSelectedMode);
    final selectedClientsNotifier = ref.read(selectedClients.notifier);
    final deleteClients = ref.watch(deleteClientsViewModel);
    final clients = ref.watch(filteredClients);
    final isLoading = clients.isLoading || deleteClients.isLoading;
    final user = ref.watch(loginViewModel).value;

    ref.listen(
      filteredClients,
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
                "Welcome ${user?.username}",
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
                  ref.read(deleteClientsViewModel.notifier).deleteClients();
                  selectedClientsNotifier.clearSelectedClients();
                }),
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
                ref.read(queryProvider.notifier).addQuery(q);
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
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 32.0,
                      right: 32,
                      bottom: 24.0,
                    ),
                    child: Column(
                      spacing: 16.0,
                      children: data.map(
                        (client) {
                          return ClientCard(
                            // key: key,
                            client: client,
                          );
                        },
                      ).toList(),
                    ),
                  ),
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
