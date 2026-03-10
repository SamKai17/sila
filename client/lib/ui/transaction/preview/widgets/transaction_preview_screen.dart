import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/information_card.dart';
import 'package:client/ui/core/ui/items_table.dart';
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
        final tx = widget.viewModel.transaction;
        double totalPrice =
            widget.viewModel.getTotalPrice(clientId: widget.clientId);
        if (tx == null) {
          return Scaffold(
            body: SizedBox(),
          );
        }
        List<Item> items = tx.items;

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
                  'Paid': '\$${tx.paid}',
                  'Total': '${totalPrice}\$'
                }),
                Spacer(),
                CustomButtonWidget(
                  buttonText: 'Confirm',
                  onPressed: () async {
                    await widget.viewModel.addTransaction.execute({
                      'clientId': widget.clientId,
                      'type': widget.type,
                    });
                    context.pushNamed(
                      Routes.transactionReceiptName,
                      pathParameters: {
                        'clientId': widget.clientId,
                        'transactionId': widget.viewModel.transactionId!,
                      },
                      queryParameters: {
                        'type': widget.type,
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
