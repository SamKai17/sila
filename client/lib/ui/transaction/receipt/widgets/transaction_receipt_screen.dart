import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/information_card.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:client/ui/transaction/receipt/view_model/transaction_receipt_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionReceiptScreen extends ConsumerWidget {
  const TransactionReceiptScreen({
    super.key,
    required String this.clientId,
    required String this.transactionId,
    required String this.type,
  });
  final String clientId;
  final String transactionId;
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionAsync =
        ref.watch(transactionProvider(transactionId));
    return transactionAsync.when(
      data: (transaction) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                ref.read(transactionCreateViewModel(clientId).notifier).clear();
                if (context.mounted) {
                  context.goNamed(Routes.transactionCreateName,
                      pathParameters: {'clientId': clientId},
                      queryParameters: {'type': type});
                }
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
                                child:
                                    ItemsTable(items: transaction.items ?? []),
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
                                '${DateTime.fromMillisecondsSinceEpoch(transaction.timeOfTransaction)}',
                            'Paid': '${transaction.payments?.last.amount}\$',
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
                                '${DateTime.fromMillisecondsSinceEpoch(transaction.timeOfTransaction)}',
                            'Total Paid': '${transaction.totalPaid}\$',
                            'Remainder': '${transaction.remainder}\$',
                            'Total': '${transaction.totalPrice}\$',
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
                    ref
                        .read(transactionCreateViewModel(clientId).notifier)
                        .clear();
                    context.goNamed(Routes.transactionDetailName,
                        pathParameters: {
                          'clientId': clientId,
                          'transactionId': transactionId
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
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text('no transaction found'),
          ),
        );
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: LoaderWidget(),
          ),
        );
      },
    );
  }
}
