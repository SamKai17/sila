import 'package:client/domain/models/item/item.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ItemCard extends ConsumerWidget {
  const ItemCard(
      {super.key,
      required Item this.item,
      required String this.cliendId,
      required this.update
      });
  final Item item;
  final String cliendId;
  final void Function({
    required String id,
    required String name,
    required double price,
    required int quantity,
  }) update;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMode = ref.watch(itemSelectedMode);
    final isSelected = ref.watch(isItemSelected(item));
    return GestureDetector(
      onTap: () {
        if (selectedMode) {
          if (isSelected) {
            ref.read(selectedItems.notifier).removeSelectedItem(item);
          } else {
            ref.read(selectedItems.notifier).addSelectedItem(item);
          }
        } else {
          context.pushNamed(
            Routes.itemUpdateName,
            pathParameters: {'clientId': cliendId},
            extra: {
              'item': item,
              'update': update,
            },
          );
        }
      },
      onLongPress: () {
        if (isSelected) {
          ref.read(selectedItems.notifier).removeSelectedItem(item);
        } else {
          ref.read(selectedItems.notifier).addSelectedItem(item);
        }
      },
      child: Card(
        color: isSelected ? AppPallete.selectedBackground : AppPallete.surface,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              if (selectedMode)
                Icon(
                  isSelected
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
