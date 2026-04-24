import 'package:client/l10n/app_localizations.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/clear_button.dart';
import 'package:client/ui/core/ui/delete_button.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:client/ui/transaction/create/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionCreateScreen extends ConsumerWidget {
  const TransactionCreateScreen({
    super.key,
    required String this.clientId,
    required String this.type,
  });
  final String clientId;
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsCart(clientId));
    final selectedMode = ref.watch(itemSelectedMode);
    final totalPrice = ref.read(itemsCart(clientId).notifier).totalPrice();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: selectedMode ? false : true,
        toolbarHeight: 72,
        surfaceTintColor: AppPallete.background,
        title: !selectedMode
            ? Text(AppLocalizations.of(context)!.transaction)
            : null,
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
                    ref.read(selectedItems.notifier).clearSelectedItems();
                    ref.read(itemsCart(clientId).notifier).deleteItems();
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
                  update: ref.read(itemsCart(clientId).notifier).updateItem,
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
                    Text(AppLocalizations.of(context)!.summary),
                    Row(
                      children: [
                        Text(AppLocalizations.of(context)!.totalPrice),
                        Spacer(),
                        Text('${totalPrice}\$'),
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
                        // queryParameters: {'type': type},
                        extra: ref.read(itemsCart(clientId).notifier).addItem,
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.addItem),
                  ),
                ),
                SizedBox(
                  width: 18.0,
                ),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      context.pushNamed(
                        Routes.transactionPaymentName,
                        pathParameters: {
                          'clientId': clientId,
                        },
                        queryParameters: {
                          'type': type,
                        },
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.pay),
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
