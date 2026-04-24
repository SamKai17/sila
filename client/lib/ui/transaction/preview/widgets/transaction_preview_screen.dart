import 'package:client/domain/models/item/item.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/information_card.dart';
import 'package:client/ui/core/ui/items_table.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:client/ui/transaction/preview/view_model/transaction_preview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionPreviewScreen extends ConsumerWidget {
  const TransactionPreviewScreen({
    super.key,
    required String this.clientId,
    required String this.type,
    required double this.paid,
  });
  final String clientId;
  final String type;
  final double paid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalPrice = ref.read(itemsCart(clientId).notifier).totalPrice();
    List<Item> items = ref.watch(itemsCart(clientId));
    final client = ref.watch(clientProvider(clientId)).value;
    final isLoading = ref.watch(transactionPreviewViewModel).isLoading;
    ref.listen(
      transactionPreviewViewModel,
      (previous, next) {
        next.when(
          data: (data) {
            // if (previous != null && previous.hasValue && next.hasValue) {
            //   if (context.mounted) {
            //     context.pop();
            //   }
            // }
          },
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('an error happened')));
          },
          loading: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${AppLocalizations.of(context)!.confirm} ${AppLocalizations.of(context)!.transaction}'),
      ),
      body: isLoading
          ? Center(
              child: LoaderWidget(),
            )
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.items),
                  SizedBox(height: 12.0),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ItemsTable(items: items),
                  )),
                  SizedBox(height: 32.0),
                  Text(AppLocalizations.of(context)!.transactionDetail),
                  SizedBox(height: 12.0),
                  InformationCard(
                    information: {
                      AppLocalizations.of(context)!.client: client?.name ?? 'Error',
                      AppLocalizations.of(context)!.pay: '\$${paid}',
                      AppLocalizations.of(context)!.total: '\$${totalPrice}'
                    },
                  ),
                  Spacer(),
                  CustomButtonWidget(
                    buttonText: AppLocalizations.of(context)!.confirm,
                    onPressed: () async {
                      final transactionId = await ref
                          .read(transactionPreviewViewModel.notifier)
                          .addTransaction(
                            totalPrice: totalPrice,
                            paid: paid,
                            items: items,
                            type: type,
                            clientId: clientId,
                          );
                      if (transactionId != null) {
                        context.pushNamed(
                          Routes.transactionReceiptName,
                          pathParameters: {
                            'clientId': clientId,
                            'transactionId': transactionId,
                          },
                          queryParameters: {
                            'type': type,
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
