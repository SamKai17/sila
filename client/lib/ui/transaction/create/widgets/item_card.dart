import 'package:client/domain/models/item/item.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required Item this.item, required this.viewModel, required String this.cliendId});
  final Item item;
  final TransactionCreateViewModel viewModel;
  final String cliendId;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!viewModel.selectedMode) {
          context.goNamed(Routes.itemUpdateName, pathParameters: {'clientId': cliendId}, extra: item);
        } else {
          if (viewModel.isSelected(item: item)) {
            viewModel.removeSelectedItem(item: item);
          } else {
            viewModel.addSelectedItem(item: item);
          }
        }
      },
      onLongPress: () {
        if (viewModel.isSelected(item: item)) {
          viewModel.removeSelectedItem(item: item);
        } else {
          viewModel.addSelectedItem(item: item);
        }
      },
      child: Card(
        color: viewModel.isSelected(item: item)
            ? AppPallete.selectedBackground
            : AppPallete.surface,
        // margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            // spacing: 0.0,
            children: [
              if (viewModel.selectedMode)
                Icon(
                  viewModel.isSelected(item: item)
                      ? Icons.check_box
                      : Icons.check_box_outline_blank_outlined,
                ),
              Expanded(
                child: Table(
                  defaultColumnWidth: IntrinsicColumnWidth(),
                  columnWidths: {1: FlexColumnWidth()},
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Qty"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Name"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Price"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Total"),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.quantity.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.name),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${item.price}\$'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${item.price * item.quantity}\$'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
