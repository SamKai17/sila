import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/clear_button.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/delete_button.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:client/ui/transaction/list/view_model/transactions_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({
    super.key,
    required String this.clientId,
  });
  final String clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider(clientId));
    final selectedMode = ref.watch(isTransactionselectedMode);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: selectedMode ? false : true,
        toolbarHeight: 72,
        surfaceTintColor: AppPallete.background,
        title: !selectedMode ? Text("Transaction") : null,
        leadingWidth: 82,
        leading: selectedMode
            ? ClearButton(
                clear: ref
                    .read(selectedTransactions.notifier)
                    .clearSelectedTransactions,
              )
            : null,
        actions: selectedMode
            ? [
                DeleteButton(delete: () async {
                  await ref
                      .read(transactionsViewModel(clientId).notifier)
                      .deleteTransactions(clientId);
                  ref
                      .read(selectedTransactions.notifier)
                      .clearSelectedTransactions();
                }),
                SizedBox(width: 32)
              ]
            : null,
      ),
      body: transactions.when(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                spacing: 16.0,
                children: data.map(
                  (transaction) {
                    return TransactionCard(
                      transaction: transaction,
                      clientId: clientId,
                    );
                  },
                ).toList(),
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('no transactions found'),
          );
        },
        loading: () {
          return Center(
            child: LoaderWidget(),
          );
        },
      ),
    );
  }
}

class TransactionCard extends ConsumerWidget {
  const TransactionCard({
    super.key,
    required Transaction this.transaction,
    required String this.clientId,
  });
  final Transaction transaction;
  final String clientId;

  int getPercentage({
    required double total,
    required double totalPaid,
  }) {
    double result = (totalPaid * 100) / total;
    if (result > 100) result = 100;
    return result.toInt();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMode = ref.watch(isTransactionselectedMode);
    final isSelected = ref.watch(isTransactionSelected(transaction));

    return GestureDetector(
      onTap: () {
        if (!selectedMode) {
          context.pushNamed(Routes.transactionDetailName, pathParameters: {
            'clientId': clientId,
            'transactionId': transaction.id
          });
        } else {
          if (isSelected) {
            ref
                .read(selectedTransactions.notifier)
                .removeSelectedTransaction(transaction);
          } else {
            ref
                .read(selectedTransactions.notifier)
                .addSelectedTransaction(transaction);
          }
        }
      },
      onLongPress: () {
        if (isSelected) {
          ref
              .read(selectedTransactions.notifier)
              .removeSelectedTransaction(transaction);
        } else {
          ref
              .read(selectedTransactions.notifier)
              .addSelectedTransaction(transaction);
        }
      },
      child: Card(
        color: isSelected ? AppPallete.selectedBackground : AppPallete.surface,
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
                  if (selectedMode)
                    Icon(
                      isSelected
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
                          totalPaid: transaction.totalPaid,
                        ) /
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
                  context.pushNamed(
                    Routes.paymentName,
                    queryParameters: {
                      'clientId': clientId,
                      'transactionId': transaction.id,
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
