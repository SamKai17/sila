import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/clear_button.dart';
import 'package:client/ui/core/ui/delete_button.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:client/ui/transaction/create/widgets/item_card.dart';
import 'package:client/ui/transaction/items_edit/view_model/items_edit_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ItemsEditScreen extends ConsumerWidget {
  const ItemsEditScreen({
    super.key,
    required Transaction this.transaction,
    required String this.clientId,
    required List<Item> this.oldItems,
  });
  final List<Item> oldItems;
  final String clientId;
  final Transaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsEditViewModel(oldItems));
    final selectedMode = ref.watch(itemSelectedMode);
    ref.listen(
      updateItems,
      (previous, next) {
        next.when(
          data: (data) {
            if (context.mounted) {
              context.pop();
            }
          },
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('an error happened')),
            );
          },
          loading: () {},
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: selectedMode ? false : true,
        toolbarHeight: 72,
        surfaceTintColor: AppPallete.background,
        title: !selectedMode ? Text("Transaction") : null,
        leadingWidth: 82,
        leading: selectedMode
            ? ClearButton(
                clear: ref.read(selectedItems.notifier).clearSelectedItems,
              )
            : null,
        actions: selectedMode
            ? [
                DeleteButton(
                  delete: () {
                    ref
                        .read(itemsEditViewModel(oldItems).notifier)
                        .deleteItems();
                    ref.read(selectedItems.notifier).clearSelectedItems();
                  },
                ),
                SizedBox(width: 32)
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            ...items.map(
              (item) {
                return ItemCard(
                  item: item,
                  cliendId: clientId,
                  update: ref
                      .read(itemsEditViewModel(oldItems).notifier)
                      .updateItem,
                );
              },
            ).toList(),
            Spacer(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  spacing: 12.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Summary"),
                    Row(
                      children: [
                        Text("Total Price"),
                        Spacer(),
                        Text(
                            '\$${ref.read(itemsEditViewModel(oldItems).notifier).totalPrice()}'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      context.pushNamed(
                        Routes.itemCreateName,
                        pathParameters: {'clientId': clientId},
                        extra: ref
                            .read(itemsEditViewModel(oldItems).notifier)
                            .addItem,
                      );
                    },
                    child: Text("+ add item"),
                  ),
                ),
                SizedBox(
                  width: 18.0,
                ),
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      await ref.read(updateItems.notifier).updateItems(
                            transaction: transaction,
                            newItems: items,
                            oldItems: oldItems,
                          );
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
