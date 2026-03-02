import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/clear_button.dart';
import 'package:client/ui/core/ui/delete_button.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:client/ui/transaction/create/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionCreateScreen extends StatefulWidget {
  const TransactionCreateScreen({
    super.key,
    required TransactionCreateViewModel this.viewModel,
    required String this.clientId,
    required String this.type,
  });
  final TransactionCreateViewModel viewModel;
  final String clientId;
  final String type;

  @override
  State<TransactionCreateScreen> createState() =>
      _TransactionCreateScreenState();
}

class _TransactionCreateScreenState extends State<TransactionCreateScreen> {
  @override
  void initState() {
    print('init page');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("init home...");
      widget.viewModel.load.execute(widget.clientId);
    });
    // set the type
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading:
                widget.viewModel.selectedMode ? false : true,
            toolbarHeight: 72,
            surfaceTintColor: AppPallete.background,
            // backgroundColor: AppPallete.avatarBackground,
            // titleSpacing: 32.0,
            title: !widget.viewModel.selectedMode ? Text("Transaction") : null,
            // : Text('${viewModel.items.length} items selected'),
            leadingWidth: 82,
            leading: widget.viewModel.selectedMode
                ? ClearButton(
                    clear: widget.viewModel.clearSelectedItems,
                  )
                : null,
            actions: widget.viewModel.selectedMode
                ? [
                    DeleteButton(
                      delete: () =>
                          widget.viewModel.deleteItems(widget.clientId),
                    ),
                    SizedBox(width: 32)
                  ]
                : null,
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                ...widget.viewModel.items.map(
                  (item) {
                    return ItemCard(
                      item: item,
                      viewModel: widget.viewModel,
                      cliendId: widget.clientId,
                    );
                  },
                ).toList(),
                Spacer(),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      spacing: 12.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Summary"),
                        Row(
                          children: [
                            Text("Total Items"),
                            Spacer(),
                            Text(widget.viewModel.totalItems.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Total Price"),
                            Spacer(),
                            Text('${widget.viewModel.totalPrice}\$'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          context.goNamed(
                            Routes.itemCreateName,
                            pathParameters: {'clientId': widget.clientId},
                            queryParameters: {'type': widget.type},
                          );
                        },
                        child: Text("+ add item"),
                      ),
                    ),
                    SizedBox(
                      width: 18.0,
                    ),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          context.goNamed(
                            Routes.transactionPaymentName,
                            pathParameters: {'clientId': widget.clientId},
                            queryParameters: {'type': widget.type},
                          );
                        },
                        child: Text("pay"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
