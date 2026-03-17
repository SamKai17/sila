import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/client/create/widgets/client_create_screen.dart';
import 'package:client/ui/client/detail/widgets/client_detail_screen.dart';
import 'package:client/ui/client/home/widgets/home_screen.dart';
import 'package:client/ui/client/update/widgets/client_update_screen.dart';
import 'package:client/ui/item/create/widgets/item_create_screen.dart';
import 'package:client/ui/item/update/widgets/item_update_screen.dart';
import 'package:client/ui/payment/edit/widgets/payment_edit_screen.dart';
import 'package:client/ui/payment/payment/widgets/payment_screen.dart';
import 'package:client/ui/payment/preview/widgets/payment_preview_screen.dart';
import 'package:client/ui/payment/receipt/widgets/payment_receipt_screen.dart';
import 'package:client/ui/transaction/create/widgets/transaction_create_screen.dart';
import 'package:client/ui/transaction/detail/widgets/transaction_detail_screen.dart';
import 'package:client/ui/transaction/items_edit/widgets/items_edit_screen.dart';
import 'package:client/ui/transaction/list/widgets/transactions_screen.dart';
import 'package:client/ui/transaction/payment/widgets/transaction_payment_screen.dart';
import 'package:client/ui/transaction/preview/widgets/transaction_preview_screen.dart';
import 'package:client/ui/transaction/receipt/widgets/transaction_receipt_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: Routes.homeName,
      path: Routes.home,
      builder: (context, state) {
        return HomeScreen();
      },
      routes: [
        GoRoute(
          name: Routes.clientCreateName,
          path: Routes.clientCreate,
          builder: (context, state) {
            return ClientCreateScreen();
          },
        ),
        GoRoute(
          name: Routes.clientDetailName,
          path: Routes.clientDetail,
          builder: (context, state) {
            final clientId = state.pathParameters['clientId']!;
            return ClientDetailScreen(
              clientId: clientId,
            );
          },
          routes: [
            GoRoute(
              name: Routes.clientUpdateName,
              path: Routes.clientUpdate,
              builder: (context, state) {
                final clientId = state.pathParameters['clientId']!;
                final values = state.extra as Map<String, String>;
                return ClientUpdateScreen(
                  clientId: clientId,
                  name: values['name']!,
                  phone: values['phone']!,
                  city: values['city']!,
                );
              },
            ),
            GoRoute(
              name: Routes.transactionCreateName,
              path: Routes.transactionCreate,
              builder: (context, state) {
                final clientId = state.pathParameters['clientId']!;
                final type = state.uri.queryParameters['type']!;
                return TransactionCreateScreen(
                  clientId: clientId,
                  type: type,
                );
              },
              routes: [
                GoRoute(
                  name: Routes.itemCreateName,
                  path: Routes.itemCreate,
                  builder: (context, state) {
                    final clientId = state.pathParameters['clientId']!;
                    final create = state.extra as void Function({
                      required String name,
                      required double price,
                      required int quantity,
                    });
                    return ItemCreateScreen(
                      clientId: clientId,
                      create: create,
                    );
                  },
                ),
                GoRoute(
                  name: Routes.itemUpdateName,
                  path: Routes.itemUpdate,
                  builder: (context, state) {
                    final clientId = state.pathParameters['clientId']!;
                    final values = state.extra as Map<String, Object>;
                    final item = values['item'] as Item;
                    final update = values['update'] as Function({
                      required String id,
                      required String name,
                      required double price,
                      required int quantity,
                    });
                    return ItemUpdateScreen(
                      item: item,
                      clientId: clientId,
                      update: update,
                    );
                  },
                ),
                GoRoute(
                    name: Routes.transactionPaymentName,
                    path: Routes.transactionPayment,
                    builder: (context, state) {
                      final clientId = state.pathParameters['clientId']!;
                      final type = state.uri.queryParameters['type']!;
                      return TransactionPaymentScreen(
                        clientId: clientId,
                        type: type,
                      );
                    },
                    routes: [
                      GoRoute(
                          name: Routes.transactionPreviewName,
                          path: Routes.transactionPreview,
                          builder: (context, state) {
                            final clientId = state.pathParameters['clientId']!;
                            final type = state.uri.queryParameters['type']!;
                            final paid = state.extra as double;
                            return TransactionPreviewScreen(
                              clientId: clientId,
                              type: type,
                              paid: paid,
                            );
                          },
                          routes: [
                            GoRoute(
                              name: Routes.transactionReceiptName,
                              path: Routes.transactionReceipt,
                              builder: (context, state) {
                                final clientId =
                                    state.pathParameters['clientId']!;
                                final transactionId =
                                    state.pathParameters['transactionId']!;
                                final type = state.uri.queryParameters['type'];
                                return TransactionReceiptScreen(
                                  clientId: clientId,
                                  type: type!,
                                  transactionId: transactionId,
                                );
                              },
                            ),
                          ]),
                    ]),
              ],
            ),
            GoRoute(
                name: Routes.transactionsName,
                path: Routes.transactions,
                builder: (context, state) {
                  final String clientId = state.pathParameters['clientId']!;
                  return TransactionsScreen(clientId: clientId);
                },
                routes: [
                  GoRoute(
                      name: Routes.transactionDetailName,
                      path: Routes.transactionDetail,
                      builder: (context, state) {
                        final String transactionId =
                            state.pathParameters['transactionId']!;
                        final String clientId =
                            state.pathParameters['clientId']!;
                        return TransactionDetailScreen(
                          transactionId: transactionId,
                          clientId: clientId,
                        );
                      },
                      routes: [
                        GoRoute(
                          name: Routes.itemsEditName,
                          path: Routes.itemsEdit,
                          builder: (context, state) {
                            final values = state.extra as Map<String, Object>;
                            final transaction =
                                values['transaction'] as Transaction;
                            final oldItems = values['oldItems'] as List<Item>;
                            final clientId =
                                state.pathParameters['clientId'] as String;
                            return ItemsEditScreen(
                              clientId: clientId,
                              transaction: transaction,
                              oldItems: oldItems,
                            );
                          },
                        ),
                        GoRoute(
                          name: Routes.paymentEditName,
                          path: Routes.paymentEdit,
                          builder: (context, state) {
                            final values = state.extra as Map<String, Object>;
                            final transaction =
                                values['transaction'] as Transaction;
                            final payment = values['payment'] as Payment;
                            return PaymentEditScreen(
                              transaction: transaction,
                              payment: payment,
                            );
                          },
                        )
                      ]),
                ]),
          ],
        ),
      ],
    ),
    GoRoute(
        name: Routes.paymentName,
        path: Routes.payment,
        builder: (context, state) {
          final transactionId =
              state.uri.queryParameters['transactionId'] as String;
          final clientId = state.uri.queryParameters['clientId'] as String;
          return PaymentScreen(
            transactionId: transactionId,
            clientId: clientId,
          );
        },
        routes: [
          GoRoute(
            name: Routes.paymentPreviewName,
            path: Routes.paymentPreview,
            builder: (context, state) {
              final paid = state.extra as double;
              final transactionId =
                  state.uri.queryParameters['transactionId'] as String;
              final clientId = state.uri.queryParameters['clientId'] as String;
              return PaymentPreviewScreen(
                  transactionId: transactionId, paid: paid, clientId: clientId);
            },
          ),
        ])
  ],
);

        //         GoRoute(
        //           name: Routes.paymentReceiptName,
        //           path: Routes.paymentReceipt,
        //           builder: (context, state) {
        //             // final amount = extra['amount'] as double;
        //             final transactionId = state.pathParameters['transactionId']!;
        //             final clientId = state.extra as String;
        //             return PaymentReceiptScreen(
        //               viewModel: context.read(),
        //               transactionId: transactionId,
        //               clientId: clientId,
        //             );
        //           },
        //         ),