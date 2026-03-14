import 'package:client/routing/routes.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientDetailScreen extends ConsumerWidget {
  const ClientDetailScreen({
    super.key,
    required String this.clientId,
  });

  final String clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(clientDetailViewModel(clientId));
    return viewModel.when(
      data: (client) {
        return Scaffold(
          appBar: AppBar(
            title: Text("client"),
            actions: [
              IconButton(
                onPressed: () {
                  context.pushNamed(
                    Routes.clientUpdateName,
                    pathParameters: {'clientId': client.id},
                    extra: {
                      'name': client.name,
                      'phone': client.phone,
                      'city': client.city
                    },
                  );
                },
                icon: Icon(Icons.edit),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
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
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
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
                  GestureDetector(
                    onTap: () {
                      // context.goNamed(
                      //   Routes.transactionsName,
                      //   pathParameters: {'clientId': client!.id},
                      // );
                    },
                    child: SizedBox(
                      height: 70.0,
                      width: 70.0,
                      child: Card(child: Icon(Icons.swap_horiz)),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                            onPressed: () {
                              // context.goNamed(
                              //   Routes.transactionCreateName,
                              //   pathParameters: {
                              //     'clientId': client.id
                              //   },
                              //   queryParameters: {'type': 'buy'},
                              // );
                            },
                            child: Text('Buy')),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                            onPressed: () {
                              // context.goNamed(
                              //   Routes.transactionCreateName,
                              //   pathParameters: {
                              //     'clientId': client.id
                              //   },
                              //   queryParameters: {'type': 'sell'},
                              // );
                            },
                            child: Text('Sell')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text('error'),
          ),
        );
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: LoaderWidget(),
          ),
        );
      },
    );
  }
}
