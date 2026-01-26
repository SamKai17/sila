import 'package:client/core/providers/auth_local_repository.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/widgets/loader_widget.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/client/view/pages/client_create_page.dart';
import 'package:client/features/client/view/widgets/client_card_widget.dart';
import 'package:client/features/client/viewmodel/client_viewmodel.dart';
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
    // final clients = ref.watch(clientListProvider);
    final clients = ref.watch(searchClientList(searchQuery));
    final user = ref.watch(currentUserProvider);
    print("search: $searchQuery");
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${user?.username}"),
        actions: [
          if (selectedMode)
            IconButton(
              onPressed: () async {
                await ref.read(clientListProvider.notifier).removeClients();
                ref.read(selectedClientsProvider.notifier).clear();
                // remove all the items
              },
              icon: Icon(Icons.delete),
            ),
          IconButton(
            onPressed: () {
              print("clear user");
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
        ],
      ),
      body: Container(
        // color: Colors.amber,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
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
                          selectedMode: selectedMode,
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Text("no clients found");
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
