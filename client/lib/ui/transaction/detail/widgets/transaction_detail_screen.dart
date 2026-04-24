import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/clear_button.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/delete_button.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:client/ui/transaction/detail/view_model/transaction_detail_viewmodel.dart';
import 'package:client/ui/transaction/detail/widgets/info_card.dart';
import 'package:client/ui/transaction/detail/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TransactionDetailScreen extends ConsumerWidget {
  TransactionDetailScreen({
    super.key,
    required String this.transactionId,
    required String this.clientId,
  });

  final String transactionId;
  final String clientId;
  final GlobalKey _captureKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionAsync = ref.watch(transactionProvider(transactionId));
    final client = ref.watch(clientProvider(clientId)).value;
    final selectedMode = ref.watch(paymentselectedMode);
    final isLoading = ref.watch(transactionDetailViewModel).isLoading;
    ref.listen(
      transactionDetailViewModel,
      (previous, next) {
        next.when(
          data: (data) {},
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('an error happened')));
          },
          loading: () {},
        );
      },
    );
    return transactionAsync.when(
      data: (transaction) {
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
                          .read(selectedPayments.notifier)
                          .clearSelectedPayments,
                    )
                  : null,
              actions: selectedMode
                  ? [
                      DeleteButton(
                        delete: () async {
                          await ref
                              .read(transactionDetailViewModel.notifier)
                              .deletePayments(transaction: transaction);
                          ref
                              .read(selectedPayments.notifier)
                              .clearSelectedPayments();
                        },
                      ),
                      SizedBox(width: 32)
                    ]
                  : null,
            ),
            body: isLoading
                ? Center(
                    child: LoaderWidget(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: RepaintBoundary(
                        key: _captureKey,
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
                                    'oldItems': transaction.items
                                            ?.map((e) => e)
                                            .toList() ??
                                        []
                                  },
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ItemsTable(
                                      items: transaction.items ?? []),
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
                                  return PaymentCard(
                                    clientId: clientId,
                                    payment: payment,
                                    transaction: transaction,
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
                            ),
                            SizedBox(height: 24.0),
                            CustomButtonWidget(
                              buttonText: 'Share',
                              onPressed: () async {
                                await ref
                                    .read(transactionDetailViewModel.notifier)
                                    .shareTransaction(_captureKey);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: LoaderWidget(),
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text('error happened!'),
          ),
        );
      },
    );
  }
}
