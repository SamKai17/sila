import 'package:client/domain/models/item/item.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/information_card.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:client/ui/transaction/preview/view_model/transaction_preview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionPreviewScreen extends ConsumerWidget {
  const TransactionPreviewScreen({
    super.key,
    required String this.clientId,
    required String this.type,
    required double this.paid,
  });
  final String clientId;
  final String type;
  final double paid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalPrice = ref.watch(itemsTotalPrice(clientId));
    List<Item> items = ref.watch(transactionCreateViewModel(clientId));
    ref.listen(
      transactionPreviewViewModel,
      (previous, next) {
        next.when(
          data: (data) {},
          error: (error, stackTrace) {},
          loading: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Preview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Items'),
            SizedBox(height: 12.0),
            Card(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ItemsTable(items: items),
            )),
            SizedBox(height: 32.0),
            Text('Details'),
            SizedBox(height: 12.0),
            InformationCard(information: {
              'Client': 'Oussama',
              'Paid': '\$${paid}',
              'Total': '\$${totalPrice}'
            }),
            Spacer(),
            CustomButtonWidget(
              buttonText: 'Confirm',
              onPressed: () async {
                final transactionId = await ref
                    .read(transactionPreviewViewModel.notifier)
                    .addTransaction(
                      totalPrice: totalPrice,
                      paid: paid,
                      items: items,
                      type: type,
                      clientId: clientId,
                    );
                if (transactionId != null) {
                  context.pushNamed(
                    Routes.transactionReceiptName,
                    pathParameters: {
                      'clientId': clientId,
                      'transactionId': transactionId,
                    },
                    queryParameters: {
                      'type': type,
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
