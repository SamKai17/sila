import 'package:client/routing/routes.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientDetailScreen extends StatefulWidget {
  const ClientDetailScreen({
    super.key,
    required ClientDetailViewModel this.viewModel,
    required String this.clientId,
  });

  final String clientId;
  final ClientDetailViewModel viewModel;
  @override
  State<ClientDetailScreen> createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("init detail...");
      widget.viewModel.load.execute(widget.clientId);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // print("detail: we disposing");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("client"),
        actions: [
          IconButton(
              onPressed: () {
                context.push(
                  '/client/update/${widget.viewModel.client!.id}',
                  // '/client/update',
                  extra: {
                    'name': widget.viewModel.client!.name,
                    'phone': widget.viewModel.client!.phone,
                    'city': widget.viewModel.client!.city
                  },
                );
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: double.infinity,
          child: ListenableBuilder(
            listenable: widget.viewModel.load,
            builder: (context, child) {
              if (widget.viewModel.load.running) {
                return LoaderWidget();
              }
              if (widget.viewModel.load.error) {
                return Center(
                  child: Text("an error happened!"),
                );
              }
              print(widget.viewModel.client?.id);
              return Column(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: AppPallete.avatarBackground,
                    foregroundColor: AppPallete.primary,
                    child: Text('o'),
                  ),
                  Text(
                    widget.viewModel.client?.name ?? 'name',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    widget.viewModel.client?.city ?? 'city',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppPallete.greyText,
                    ),
                  ),
                  Text(
                    widget.viewModel.client?.phone ?? 'phone',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppPallete.greyText,
                    ),
                  ),
                  SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      context.push('/${Routes.transactionList}', extra: widget.clientId);
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
                              context.push('/${Routes.transactionCreate}',
                                  extra: {
                                    'type': 'buy',
                                    'clientId': widget.clientId
                                  });
                            },
                            child: Text('Buy')),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                            onPressed: () {
                              context.push('/${Routes.transactionCreate}',
                                  extra: {
                                    'type': 'sell',
                                    'clientId': widget.clientId
                                  });
                            },
                            child: Text('Sell')),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
