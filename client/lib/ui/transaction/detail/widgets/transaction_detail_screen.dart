import 'package:client/ui/transaction/detail/view_model/transaction_detail_viewmodel.dart';
import 'package:flutter/material.dart';

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