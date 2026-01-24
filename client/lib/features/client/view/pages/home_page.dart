import 'package:client/core/providers/auth_local_repository.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/widgets/loader_widget.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/client/view/widgets/client_card_widget.dart';
import 'package:client/features/client/viewmodel/client_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clients = ref.watch(clientProvider);
    print("here");
    // ref.read(clientProvider.notifier).getAllClients();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              print("clear user");
              ref.read(currentUserProvider.notifier).setUser(null);
              ref.read(authLocalRepositoryProvider).clearTokens();
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: clients.when(
                  data: (data) {
                    print(data.length);
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        // final client = data[index];
                        return ClientCardWidget();
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    return Text("no clients found");
                  },
                  loading: () {
                    return LoaderWidget();
                  },
                ),
              ),
              Spacer(),
              FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
            ],
          ),
        ),
      ),
    );
  }
}
