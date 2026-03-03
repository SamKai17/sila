import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/transaction/list/view_model/transactions_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({
    super.key,
    required TransactionsViewModel this.viewModel,
    required String this.clientId,
  });
  final TransactionsViewModel viewModel;
  final String clientId;

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.load.execute(widget.clientId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          final transactions = widget.viewModel.transactions;
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16.0,
                children: transactions.map(
                  (transaction) {
                    return GestureDetector(
                      onTap: () {
                        context.goNamed(Routes.transactionDetailName,
                            pathParameters: {
                              'clientId': widget.clientId,
                              'transactionId': transaction.id
                            });
                      },
                      child: Container(
                        width: double.infinity,
                        child: TransactionCard(
                          transaction: transaction,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required Transaction this.transaction});
  final Transaction transaction;

  int getPercentage({
    required double total,
    required double totalPaid,
  }) {
    double result = (totalPaid * 100) / total;
    return result.toInt();
  }

  // double getProgressBarWidth({required int maxWidth, required int percentage}) {
  //   double result = (percentage * maxWidth) / 100;
  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          spacing: 10.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${transaction.type[0].toUpperCase()}${transaction.type.substring(1)} Transaction'),
            Row(
              spacing: 10.0,
              children: [
                Icon(Icons.access_time_filled),
                Text(
                    '${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(transaction.timeOfTransaction))}'),
              ],
            ),
            Row(
              children: [
                Text('Payment Progress'),
                Spacer(),
                Text(
                    '${getPercentage(total: transaction.totalPrice, totalPaid: transaction.totalPaid)}%'),
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF252428),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: getPercentage(
                          total: transaction.totalPrice,
                          totalPaid: transaction.totalPaid) /
                      100,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Due',
                    ),
                    Text(
                      '${transaction.remainder}\$',
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                    ),
                    Text(
                      '${transaction.totalPrice}\$',
                    ),
                  ],
                )
              ],
            ),
            CustomButtonWidget(
              buttonText: 'Pay',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
