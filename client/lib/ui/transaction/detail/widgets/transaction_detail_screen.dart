import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/information_card.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/transaction/detail/view_model/transaction_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TransactionDetailScreen extends ConsumerWidget {
  const TransactionDetailScreen({
    super.key,
    required String this.transactionId,
    required String this.clientId,
  });

  final String transactionId;
  final String clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionAsync = ref.watch(transactionProvider(transactionId));
    final client = ref.watch(clientDetailViewModel(clientId)).value;

    return Scaffold(
      appBar: AppBar(),
      body: transactionAsync.when(
        data: (transaction) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'General Information',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    spacing: 24.0,
                    children: [
                      Expanded(
                        child: InfoCard(
                          title: 'Total',
                          value: '\$${transaction.totalPrice}',
                        ),
                      ),
                      Expanded(
                        child: InfoCard(
                          title: 'Remainder',
                          value: '\$${transaction.remainder}',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    spacing: 24.0,
                    children: [
                      Expanded(
                        child: InfoCard(
                          title: 'Paid',
                          value: '\$${transaction.totalPaid}',
                        ),
                      ),
                      Expanded(
                        child: InfoCard(
                          title: 'Date',
                          value:
                              '${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(transaction.timeOfTransaction))}',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    spacing: 24.0,
                    children: [
                      Expanded(
                        child: InfoCard(
                          title: 'Client',
                          value: client?.name ?? 'Error',
                        ),
                      ),
                      Expanded(
                        child: InfoCard(
                          title: 'Type',
                          value: transaction.type,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'items',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 24.0),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        Routes.itemsEditName,
                        pathParameters: {
                          'transactionId': transactionId,
                          'clientId': clientId,
                        },
                        extra: {
                          'transaction': transaction,
                          'oldItems': transaction.items?.map((e) => e).toList() ?? []
                        },
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ItemsTable(items: transaction.items ?? []),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'Payments',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 24.0),
                  if (transaction.payments != null)
                    ...transaction.payments!.map(
                      (payment) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: InformationCard(information: {
                            'Payment Date':
                                '${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(payment.timeOfPayment))}',
                            'Paid': '${payment.amount}\$'
                          }),
                        );
                      },
                    ).toList(),
                  SizedBox(height: 32.0),
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
          );
        },
        error: (error, stackTrace) {},
        loading: () {},
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key, required String this.title, required String this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.0,
          children: [
            Text(title),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
