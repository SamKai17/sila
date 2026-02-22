import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/clear_button.dart';
import 'package:client/ui/core/ui/delete_button.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:client/ui/transaction/create/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionCreateScreen extends StatelessWidget {
  const TransactionCreateScreen(
      {super.key, required TransactionCreateViewModel this.viewModel});
  final TransactionCreateViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: viewModel.selectedMode ? false : true,
            toolbarHeight: 72,
            surfaceTintColor: AppPallete.background,
            // backgroundColor: AppPallete.avatarBackground,
            // titleSpacing: 32.0,
            title: !viewModel.selectedMode ? Text("Transaction") : null,
            // : Text('${viewModel.items.length} items selected'),
            leadingWidth: 82,
            leading: viewModel.selectedMode
                ? ClearButton(
                    clear: viewModel.clearSelectedItems,
                  )
                : null,
            actions: viewModel.selectedMode
                ? [
                    DeleteButton(delete: viewModel.deleteSelectedItems),
                    SizedBox(width: 32)
                  ]
                : null,

            // title: Text('transaction create'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                // ItemCard(
                //     item: Item(
                //         id: '',
                //         name: 'ddsfklsjflksdjflskdjflksdjflksjfdlkj',
                //         price: 12.0,
                //         quantity: 10)),
                ...viewModel.items.map(
                  (item) {
                    return ItemCard(
                      item: item,
                      viewModel: viewModel,
                    );
                  },
                ).toList(),
                Spacer(),
                Card(
                  // margin: EdgeInsets.all(0),
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
                            Text(viewModel.totalItems.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Total Price"),
                            Spacer(),
                            Text('${viewModel.totalPrice}\$'),
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
                          context.push('/${Routes.itemCreate}');
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
                          context.push('/${Routes.transactionPayment}');
                        },
                        child: Text("pay"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
