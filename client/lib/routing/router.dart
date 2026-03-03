import 'package:client/domain/models/item/item.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/client/create/view_model/client_create_viewmodel.dart';
import 'package:client/ui/client/create/widgets/client_create_screen.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/client/detail/widgets/client_detail_screen.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/ui/client/home/widgets/home_screen.dart';
import 'package:client/ui/client/update/view_model/client_update_viewmodel.dart';
import 'package:client/ui/client/update/widgets/client_update_screen.dart';
import 'package:client/ui/item/create/widgets/item_create_screen.dart';
import 'package:client/ui/item/update/widgets/item_update_screen.dart';
import 'package:client/ui/transaction/create/widgets/transaction_create_screen.dart';
import 'package:client/ui/transaction/detail/widgets/transaction_detail_screen.dart';
import 'package:client/ui/transaction/list/widgets/transactions_screen.dart';
import 'package:client/ui/transaction/payment/widgets/transaction_payment_screen.dart';
import 'package:client/ui/transaction/preview/widgets/transaction_preview_screen.dart';
import 'package:client/ui/transaction/receipt/widgets/transaction_receipt_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: Routes.homeName,
      path: Routes.home,
      builder: (context, state) {
        // print("building home...");
        final viewModel = context.read<HomeViewModel>();
        return HomeScreen(
          viewModel: viewModel,
        );
      },
      routes: [
        GoRoute(
          name: Routes.clientCreateName,
          path: Routes.clientCreate,
          builder: (context, state) {
            final viewModel = context.read<ClientCreateViewModel>();
            return ClientCreateScreen(
              viewModel: viewModel,
            );
          },
        ),
        GoRoute(
          name: Routes.clientDetailName,
          path: Routes.clientDetail,
          builder: (context, state) {
            // print("building detail...");
            final clientId = state.pathParameters['clientId']!;
            final viewModel = context.read<ClientDetailViewModel>();
            return ClientDetailScreen(
              viewModel: viewModel,
              clientId: clientId,
            );
          },
          routes: [
            GoRoute(
              name: Routes.clientUpdateName,
              path: Routes.clientUpdate,
              builder: (context, state) {
                // print("building update...");
                final clientId = state.pathParameters['clientId']!;
                final values = state.extra as Map<String, String>;
                final viewModel = context.read<ClientUpdateViewModel>();
                return ClientUpdateScreen(
                  viewModel: viewModel,
                  clientId: clientId,
                  name: values['name']!,
                  phone: values['phone']!,
                  city: values['city']!,
                );
              },
            ),
            GoRoute(
              name: Routes.transactionsName,
              path: Routes.transactions,
              builder: (context, state) {
                final String clientId = state.pathParameters['clientId']!;
                return TransactionsScreen(
                    viewModel: context.read(), clientId: clientId);
              },
              routes: [
                GoRoute(
                  name: Routes.transactionDetailName,
                  path: Routes.transactionDetail,
                  builder: (context, state) {
                    final String transactionId =
                        state.pathParameters['transactionId']!;
                    return TransactionDetailScreen(
                      viewModel: context.read(),
                      transactionId: transactionId,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              name: Routes.transactionCreateName,
              path: Routes.transactionCreate,
              builder: (context, state) {
                // final extra = state.extra as Map<String, String>;
                final clientId = state.pathParameters['clientId']!;
                final type = state.uri.queryParameters['type'];
                // print(type);
                return TransactionCreateScreen(
                  viewModel: context.read(),
                  clientId: clientId,
                  type: type!,
                );
              },
              routes: [
                GoRoute(
                  name: Routes.itemCreateName,
                  path: Routes.itemCreate,
                  builder: (context, state) {
                    final clientId = state.pathParameters['clientId']!;
                    final type = state.uri.queryParameters['type'];
                    return ItemCreateScreen(
                      viewModel: context.read(),
                      clientId: clientId,
                      type: type!,
                    );
                  },
                ),
                GoRoute(
                  name: Routes.itemUpdateName,
                  path: Routes.itemUpdate,
                  builder: (context, state) {
                    final clientId = state.pathParameters['clientId']!;
                    final Item item = state.extra as Item;
                    return ItemUpdateScreen(
                      viewModel: context.read(),
                      item: item,
                      clientId: clientId,
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
                      viewModel: context.read(),
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
                        return TransactionPreviewScreen(
                          viewModel: context.read(),
                          clientId: clientId,
                          type: type,
                        );
                      },
                      routes: [
                        GoRoute(
                          name: Routes.transactionReceiptName,
                          path: Routes.transactionReceipt,
                          builder: (context, state) {
                            final clientId = state.pathParameters['clientId']!;
                            final transactionId =
                                state.pathParameters['transactionId']!;
                            final type = state.uri.queryParameters['type'];
                            return TransactionReceiptScreen(
                              viewModel: context.read(),
                              clientId: clientId,
                              type: type!,
                              transactionId: transactionId,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
