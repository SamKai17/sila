import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionPreviewScreen extends StatelessWidget {
  const TransactionPreviewScreen(
      {super.key, required TransactionCreateViewModel this.viewModel});
  final TransactionCreateViewModel viewModel;

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
              color: AppPallete.surface,
              child: Table(
                defaultColumnWidth: IntrinsicColumnWidth(),
                columnWidths: {1: FlexColumnWidth()},
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Quantity'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Name'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Price'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Total'),
                      ),
                    ],
                  ),
                  ...viewModel.items
                      .map(
                        (item) => TableRow(
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
                              child: Text('\$${item.price}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('\$${item.price * item.quantity}'),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            Text('Details'),
            SizedBox(height: 12.0),
            Card(
              color: AppPallete.surface,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  spacing: 12.0,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Client'),
                        Text('Oussama'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Paid'),
                        Text('\$${viewModel.paid}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total items'),
                        Text(viewModel.totalItems.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        Text('\$${viewModel.totalPrice}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            CustomButtonWidget(
              buttonText: 'Confirm',
              onPressed: () async {
                await viewModel.addTransaction.execute();
                // save the transaction
                context.push('/${Routes.transactionReceipt}');
              },
            )
          ],
        ),
      ),
    );
  }
}