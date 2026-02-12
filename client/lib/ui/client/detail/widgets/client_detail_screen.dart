import 'package:client/routing/routes.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientDetailScreen extends StatelessWidget {
  const ClientDetailScreen(
      {super.key, required ClientDetailViewModel this.viewModel});

  final ClientDetailViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("client"),
        actions: [
          IconButton(
              onPressed: () {
                context.go(
                  '/client/${viewModel.client!.id}/update',
                  extra: {
                    'name': viewModel.client!.name,
                    'phone': viewModel.client!.phone,
                    'city': viewModel.client!.city
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
            listenable: viewModel.load,
            builder: (context, child) {
              if (viewModel.load.running) {
                return LoaderWidget();
              }
              if (viewModel.load.error) {
                return Center(
                  child: Text("an error happened!"),
                );
              }
              return Column(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: AppPallete.avatarBackground,
                    foregroundColor: AppPallete.primary,
                    child: Text('o'),
                  ),
                  Text(
                    viewModel.client?.name ?? 'name',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    viewModel.client?.city ?? 'city',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppPallete.greyText,
                    ),
                  ),
                  Text(
                    viewModel.client?.phone ?? 'phone',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppPallete.greyText,
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    height: 70.0,
                    width: 70.0,
                    child: Card(child: Icon(Icons.swap_horiz)),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child:
                            FilledButton(onPressed: () {}, child: Text('Buy')),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child:
                            FilledButton(onPressed: () {}, child: Text('Sell')),
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
