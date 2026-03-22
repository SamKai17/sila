import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/information_card.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:client/ui/payment/preview/view_model/payment_preview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PaymentPreviewScreen extends ConsumerWidget {
  const PaymentPreviewScreen({
    super.key,
    required String this.transactionId,
    required String this.clientId,
    required double this.paid,
  });
  final String transactionId;
  final String clientId;
  final double paid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionAsync = ref.watch(transactionProvider(transactionId));
    final client = ref.watch(clientProvider(clientId)).value;
    ref.listen(
      paymentPreviewViewModel,
      (previous, next) {
        next.when(
          data: (data) {
            if (context.mounted) {
              context.pushNamed(Routes.transactionReceiptName, pathParameters: {
                'clientId': clientId,
                'transactionId': transactionId,
              }, queryParameters: {
                'type': transactionAsync.value?.type,
                // fix this
              });
            }
          },
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('an error happened')));
          },
          loading: () {},
        );
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Transaction Preview'),
        ),
        body: transactionAsync.when(
          data: (transaction) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Items'),
                  SizedBox(height: 12.0),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ItemsTable(items: transaction.items ?? []),
                  )),
                  SizedBox(height: 32.0),
                  Text('Details'),
                  SizedBox(height: 12.0),
                  InformationCard(information: {
                    'Client': client?.name ?? 'Error',
                    'Paid': '\$${paid}',
                    'Total': '\$${transaction.totalPrice}'
                  }),
                  Spacer(),
                  CustomButtonWidget(
                    buttonText: 'Confirm',
                    onPressed: () async {
                      await ref
                          .read(paymentPreviewViewModel.notifier)
                          .addPayment(paid: paid, transaction: transaction);
                    },
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text('error'),
            );
          },
          loading: () {
            return Center(
              child: LoaderWidget(),
            );
          },
        ));
  }
}
