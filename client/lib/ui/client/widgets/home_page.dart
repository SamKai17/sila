import 'package:client/core/failure/failure.dart';
import 'package:client/core/providers/auth_local_repository.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader_widget.dart';
import 'package:client/ui/auth/widgets/login_page.dart';
import 'package:client/ui/client/view_model/client_viewmodel.dart';
import 'package:client/ui/client/widgets/client_create_page.dart';
import 'package:client/ui/client/widgets/client_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final selectedClients = ref.watch(selectedClientsProvider);
    bool selectedMode = selectedClients.isEmpty ? false : true;
    final clients = ref.watch(searchClientList(searchQuery));
    // final clients = ref.watch(clientListProvider);
    // final user = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        leadingWidth: 68,
        leading: selectedMode
            ? Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Center(
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppPallete.surface,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        ref.read(currentUserProvider.notifier).setUser(null);
                        // ref.read(selectedClientsProvider.notifier).clear();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                ),
              )
            : null,
        title: !selectedMode ? Text("Sila") : null,
        titleSpacing: 18.0,
        actions: [
          selectedMode
              ? Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppPallete.surface,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Center(child: Text("Delete this client?")),

                            // content: Text("this action can't be reversed"),
                            // actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () async {
                                        await ref
                                            .read(clientListProvider.notifier)
                                            .removeClients();
                                        ref
                                            .read(
                                              selectedClientsProvider.notifier,
                                            )
                                            .clear();
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text("Confirm"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                )
              : Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppPallete.surface,
                  ),
                  child: IconButton(
                    onPressed: () {
                      ref.read(currentUserProvider.notifier).setUser(null);
                      ref.read(authLocalRepositoryProvider).clearTokens();
                      ref.invalidate(clientListProvider);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.logout),
                  ),
                ),
          SizedBox(width: 18),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  contentPadding: EdgeInsets.all(10.0),
                  filled: true,
                  fillColor: AppPallete.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: searchQuery != ''
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                              _searchController.clear();
                            });
                          },
                          icon: Icon(Icons.close),
                        )
                      : null,
                ),
              ),
              SizedBox(height: 32.0),
              clients.when(
                data: (data) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12.0);
                      },
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final client = data[index];
                        // print(client);
                        return ClientCardWidget(
                          key: ValueKey(client.id),
                          client: client,
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  final err = error as AppFailure;
                  return Text(err.toString());
                },
                loading: () {
                  return LoaderWidget();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ClientCreatePage();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
