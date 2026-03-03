import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/information_card.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/transaction/receipt/view_model/transaction_receipt_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionReceiptScreen extends StatefulWidget {
  const TransactionReceiptScreen({
    super.key,
    required TransactionReceiptViewModel this.viewModel,
    required String this.clientId,
    required String this.transactionId,
    required String this.type,
  });
  final TransactionReceiptViewModel viewModel;
  final String clientId;
  final String transactionId;
  final String type;

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
                  queryParameters: {'type': widget.type}
                );
              },
              icon: Icon(Icons.close),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Successful Transaction',
                            style: TextStyle(
                                fontSize: 28.0, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 32.0),
                          Text(
                            'Items',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 12.0),
                          Card(
                              margin: EdgeInsets.all(0.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ItemsTable(
                                    items: widget.viewModel.transaction != null
                                        ? widget.viewModel.transaction!.items ??
                                            []
                                        : []),
                              )),
                          SizedBox(height: 32.0),
                          Text(
                            'Client',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 12.0),
                          InformationCard(information: {
                            'Name': 'Oussama',
                            'Phone': '0689231289',
                            'City': 'Casablanca',
                          }),
                          SizedBox(height: 32.0),
                          Text(
                            'Payment detail',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 12.0),
                          InformationCard(information: {
                            'Payment Date':
                                '${widget.viewModel.transaction != null ? DateTime.fromMillisecondsSinceEpoch(widget.viewModel.transaction!.payments?.last.timeOfPayment ?? 0) : null}',
                            'Paid':
                                '${widget.viewModel.transaction != null ? widget.viewModel.transaction!.payments?.last.amount : null}\$',
                          }),
                          SizedBox(height: 32.0),
                          Text(
                            'Transaction detail',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 12.0),
                          InformationCard(information: {
                            'Transaction Date':
                                '${widget.viewModel.transaction != null ? DateTime.fromMillisecondsSinceEpoch(widget.viewModel.transaction!.timeOfTransaction) : null}',
                            'Total Paid':
                                '${widget.viewModel.transaction != null ? widget.viewModel.transaction!.totalPaid : null}\$',
                            'Remainder':
                                '${widget.viewModel.transaction != null ? widget.viewModel.transaction!.remainder : null}\$',
                            'Total':
                                '${widget.viewModel.transaction != null ? widget.viewModel.transaction!.totalPrice : null}\$',
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
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
