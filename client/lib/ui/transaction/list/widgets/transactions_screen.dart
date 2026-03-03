import 'package:client/routing/routes.dart';
import 'package:client/ui/transaction/list/view_model/transactions_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                        child: Card(
                          child: Column(
                            children: [
                              Text(
                                'total price: ${transaction.totalPrice.toString()}',
                              ),
                              Text(
                                'total paid: ${transaction.totalPaid.toString()}',
                              ),
                              Text(
                                'remainder: ${transaction.remainder.toString()}',
                              ),
                              Text(
                                'type: ${transaction.type}',
                              ),
                            ],
                          ),
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
