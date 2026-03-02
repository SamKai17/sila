import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/transaction/preview/view_model/transaction_preview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionPreviewScreen extends StatefulWidget {
  const TransactionPreviewScreen({
    super.key,
    required TransactionPreviewViewModel this.viewModel,
    required String this.clientId,
    required String this.type,
  });
  final TransactionPreviewViewModel viewModel;
  final String clientId;
  final String type;

  @override
  State<TransactionPreviewScreen> createState() =>
      _TransactionPreviewScreenState();
}

class _TransactionPreviewScreenState extends State<TransactionPreviewScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("init preview...");
      widget.viewModel.load.execute(widget.clientId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
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
                      if (widget.viewModel.transaction != null)
                        ...widget.viewModel.transaction!.items
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
                                    child:
                                        Text('\$${item.price * item.quantity}'),
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
                            Text('\$${widget.viewModel.transaction?.paid}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total items'),
                            Text('12'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total'),
                            Text('\$1000.0'),
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
                    await widget.viewModel.addTransaction.execute(
                        {'clientId': widget.clientId, 'type': widget.type});
                    context.goNamed(Routes.transactionReceiptName,
                        pathParameters: {
                          'clientId': widget.clientId,
                          'transactionId': widget.viewModel.transactionId!
                        },
                        queryParameters: {
                          'type': widget.type,
                        });
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
