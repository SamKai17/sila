import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/information_card.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/payment/preview/view_model/payment_preview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentPreviewScreen extends StatefulWidget {
  const PaymentPreviewScreen({
    super.key,
    required Transaction this.transaction,
    required PaymentPreviewViewModel this.viewModel,
    required String this.clientId,
    required double this.amount,
  });
  final Transaction transaction;
  final PaymentPreviewViewModel viewModel;
  final String clientId;
  final double amount;

  @override
  State<PaymentPreviewScreen> createState() => _PaymentPreviewScreenState();
}

class _PaymentPreviewScreenState extends State<PaymentPreviewScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("init preview...");
      // widget.viewModel.load.execute(widget.clientId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: ItemsTable(items: widget.transaction.items ?? []),
            )),
            SizedBox(height: 32.0),
            Text('Details'),
            SizedBox(height: 12.0),
            InformationCard(information: {
              'Client': 'Oussama',
              'Paid': '\$${widget.amount}',
              'Total': '\$${widget.transaction.totalPrice}'
            }),
            Spacer(),
            CustomButtonWidget(
              buttonText: 'Confirm',
              onPressed: () async {
                await widget.viewModel.addPayment.execute({
                  'amount': widget.amount,
                  'transaction': widget.transaction,
                });
                context.pushNamed(
                  Routes.paymentReceiptName,
                  pathParameters: {
                    'transactionId': widget.transaction.id,
                  },
                  extra: widget.clientId,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
