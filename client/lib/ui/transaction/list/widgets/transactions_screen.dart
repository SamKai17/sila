import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/clear_button.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/delete_button.dart';
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
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        final transactions = widget.viewModel.transactions;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading:
                widget.viewModel.selectedMode ? false : true,
            toolbarHeight: 72,
            surfaceTintColor: AppPallete.background,
            title: !widget.viewModel.selectedMode ? Text("Transaction") : null,
            leadingWidth: 82,
            leading: widget.viewModel.selectedMode
                ? ClearButton(
                    clear: widget.viewModel.clearSelectedTransactions,
                  )
                : null,
            actions: widget.viewModel.selectedMode
                ? [
                    DeleteButton(
                      delete: () =>
                          widget.viewModel.deleteTransactions(widget.clientId),
                    ),
                    SizedBox(width: 32)
                  ]
                : null,
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16.0,
                children: transactions.map(
                  (transaction) {
                    return TransactionCard(
                      transaction: transaction,
                      viewModel: widget.viewModel,
                      clientId: widget.clientId,
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required Transaction this.transaction,
    required TransactionsViewModel this.viewModel,
    required String this.clientId,
  });
  final Transaction transaction;
  final TransactionsViewModel viewModel;
  final String clientId;

  int getPercentage({
    required double total,
    required double totalPaid,
  }) {
    double result = (totalPaid * 100) / total;
    return result.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print('pressed');
        if (!viewModel.selectedMode) {
          // context.pushNamed(Routes.transactionDetailName, pathParameters: {
          //   'clientId': clientId,
          //   'transactionId': transaction.id
          // });
        } else {
          // print('selected mode');
          if (viewModel.isSelected(transaction: transaction)) {
            // print('remove selected item');
            viewModel.removeSelectedTransaction(transaction: transaction);
          } else {
            viewModel.addSelectedTransaction(transaction: transaction);
          }
        }
      },
      onLongPress: () {
        // print('long press');
        if (viewModel.isSelected(transaction: transaction)) {
          viewModel.removeSelectedTransaction(transaction: transaction);
        } else {
          viewModel.addSelectedTransaction(transaction: transaction);
        }
      },
      child: Card(
        color: viewModel.isSelected(transaction: transaction)
            ? AppPallete.selectedBackground
            : AppPallete.surface,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            spacing: 10.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${transaction.type[0].toUpperCase()}${transaction.type.substring(1)} Transaction',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Spacer(),
                  if (viewModel.selectedMode)
                    Icon(
                      viewModel.isSelected(transaction: transaction)
                          ? Icons.check_box
                          : Icons.check_box_outline_blank_outlined,
                    ),
                ],
              ),
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
              // if (transaction.remainder != 0)
              // maybe lead the button but with different style
              CustomButtonWidget(
                buttonText: 'Pay',
                onPressed: () {
                  // context.pushNamed(
                  //   Routes.paymentName,
                  //   extra: {
                  //     'clientId': clientId,
                  //     'transactionId': transaction.id,
                  //   } 
                  // );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
