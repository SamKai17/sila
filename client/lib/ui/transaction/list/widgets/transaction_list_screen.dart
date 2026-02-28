import 'package:client/routing/routes.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({
    super.key,
    required TransactionCreateViewModel this.viewModel,
    required String this.clientId,
  });
  final TransactionCreateViewModel viewModel;
  final String clientId;

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("init home...");
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
            child: Container(
              // color: Colors.amber,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16.0,
                  children: transactions.map(
                    (transaction) {
                      return GestureDetector(
                        onTap: () {
                          context.push('/transaction/${transaction.id}');
                        },
                        child: Container(
                          height: 100.0,
                          width: 300.0,
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
            ),
          );
        },
      ),
    );
  }
}
