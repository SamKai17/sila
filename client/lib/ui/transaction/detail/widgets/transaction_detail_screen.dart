import 'package:client/ui/core/ui/information_card.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/transaction/detail/view_model/transaction_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionDetailScreen extends StatefulWidget {
  const TransactionDetailScreen({
    super.key,
    required TransactionDetailViewModel this.viewModel,
    required String this.transactionId,
  });

  final TransactionDetailViewModel viewModel;
  final String transactionId;

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.load.execute(widget.transactionId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListenableBuilder(
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'General Information',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 24.0),
                Column(
                  spacing: 32.0,
                  children: [
                    Row(
                      spacing: 24.0,
                      children: [
                        Expanded(
                          child: InfoCard(
                            title: 'Total',
                            value:
                                '${widget.viewModel.transaction != null ? widget.viewModel.transaction!.totalPrice : null}\$',
                          ),
                        ),
                        Expanded(
                          child: InfoCard(
                            title: 'Remainder',
                            value:
                                '${widget.viewModel.transaction != null ? widget.viewModel.transaction!.remainder : null}\$',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 24.0,
                      children: [
                        Expanded(
                          child: InfoCard(
                            title: 'Paid',
                            value:
                                '${widget.viewModel.transaction != null ? widget.viewModel.transaction!.totalPaid : null}\$',
                          ),
                        ),
                        Expanded(
                          child: InfoCard(
                            title: 'Date',
                            value:
                                '${widget.viewModel.transaction != null ? DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(widget.viewModel.transaction!.timeOfTransaction)) : null}',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 24.0,
                      children: [
                        Expanded(
                          child: InfoCard(
                            title: 'Client',
                            value: 'Oussama',
                          ),
                        ),
                        Expanded(
                          child: InfoCard(
                            title: 'Type',
                            value:
                                '${widget.viewModel.transaction != null ? widget.viewModel.transaction!.type : null}',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                Text(
                  'items',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 24.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ItemsTable(
                        items: widget.viewModel.transaction != null
                            ? widget.viewModel.transaction!.items ?? []
                            : []),
                  ),
                ),
                SizedBox(height: 32.0),
                Text(
                  'Payments',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 24.0),
                if (widget.viewModel.transaction != null)
                  if (widget.viewModel.transaction!.payments != null)
                    ...widget.viewModel.transaction!.payments!.map(
                      (payment) {
                        return InformationCard(information: {
                          'Payment Date':
                              '${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(payment.timeOfPayment))}',
                          'Paid': '${payment.amount}\$'
                        });
                      },
                    ).toList(),
              ],
            ),
          );
        },
        listenable: widget.viewModel,
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
