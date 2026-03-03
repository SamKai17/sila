import 'package:client/domain/models/item/item.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required Item this.item,
    required this.viewModel,
    required String this.cliendId,
    required String this.type,
  });
  final Item item;
  final TransactionCreateViewModel viewModel;
  final String cliendId;
  final String type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!viewModel.selectedMode) {
          context.goNamed(
            Routes.itemUpdateName,
            pathParameters: {'clientId': cliendId},
            extra: item,
            queryParameters: {'type': type},
          );
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              if (viewModel.selectedMode)
                Icon(
                  viewModel.isSelected(item: item)
                      ? Icons.check_box
                      : Icons.check_box_outline_blank_outlined,
                ),
              Expanded(
                child: ItemsTable(items: [item]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
