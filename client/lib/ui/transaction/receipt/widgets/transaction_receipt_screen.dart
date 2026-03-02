import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/transaction/receipt/view_model/transaction_receipt_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionReceiptScreen extends StatefulWidget {
  const TransactionReceiptScreen({
    super.key,
    required TransactionReceiptViewModel this.viewModel,
    required String this.clientId,
    required String this.transactionId,
  });
  final TransactionReceiptViewModel viewModel;
  final String clientId;
  final String transactionId;

  @override
  State<TransactionReceiptScreen> createState() =>
      _TransactionReceiptScreenState();
}

class _TransactionReceiptScreenState extends State<TransactionReceiptScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("init preview...");
      widget.viewModel.load.execute(widget.transactionId);
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
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                context.goNamed(
                  Routes.transactionCreateName,
                  pathParameters: {'clientId': widget.clientId},
                );
              },
              icon: Icon(Icons.close),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                    'total price: ${widget.viewModel.transaction?.totalPrice}'),
                Text('total paid: ${widget.viewModel.transaction?.totalPaid}'),
                Text('remainder: ${widget.viewModel.transaction?.remainder}'),
                Spacer(),
                CustomButtonWidget(
                  buttonText: 'View Transaction',
                  onPressed: () {
                    context.goNamed(Routes.transactionDetailName,
                        pathParameters: {
                          'clientId': widget.clientId,
                          'transactionId': widget.transactionId
                        });
                  },
                ),
                SizedBox(height: 12.0),
                CustomButtonWidget(
                  buttonText: 'Share',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
