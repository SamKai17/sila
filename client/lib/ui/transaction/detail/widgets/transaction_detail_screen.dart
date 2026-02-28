import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter/material.dart';

class TransactionDetailScreen extends StatefulWidget {
  const TransactionDetailScreen(
      {super.key, required TransactionCreateViewModel this.viewModel, required String this.transactionId});
  final TransactionCreateViewModel viewModel;
  final String transactionId;

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.loadTransaction.execute(widget.transactionId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListenableBuilder(
        builder: (context, child) {
          // if (widget.viewModel.loadTransaction.running) {
          //   return Center(child: ,)
          // }
          return Column(
            children: [
              Text(
                'total paid: ${widget.viewModel.transaction?.totalPaid.toString()}',
              ),
              Text(
                'total price: ${widget.viewModel.transaction?.totalPrice.toString()}',
              ),
              Text(
                'remainder: ${widget.viewModel.transaction?.remainder.toString()}',
              ),
            ],
          );
        },
        listenable: widget.viewModel,
      ),
    );
  }
}
