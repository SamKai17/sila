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
import 'package:client/ui/transaction/list/widgets/transaction_list_screen.dart';
import 'package:client/ui/transaction/payment/widgets/transaction_payment_screen.dart';
import 'package:client/ui/transaction/preview/widgets/transaction_preview_screen.dart';
import 'package:client/ui/transaction/receipt/widgets/transaction_receipt_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
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
          path: Routes.clientDetail,
          builder: (context, state) {
            // print("building detail...");
            final clientId = state.pathParameters['id']!;
            final viewModel = context.read<ClientDetailViewModel>();
            return ClientDetailScreen(
              viewModel: viewModel,
              clientId: clientId,
            );
          },
        ),
        GoRoute(
          path: Routes.clientUpdate,
          builder: (context, state) {
            // print("building update...");
            final clientId = state.pathParameters['id']!;
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
          path: Routes.clientCreate,
          builder: (context, state) {
            // print("building create...");
            final viewModel = context.read<ClientCreateViewModel>();
            return ClientCreateScreen(
              viewModel: viewModel,
            );
          },
        ),
        GoRoute(
          path: Routes.transactionCreate,
          builder: (context, state) {
            return TransactionCreateScreen(
              viewModel: context.read(),
            );
          },
        ),
        GoRoute(
          path: Routes.itemCreate,
          builder: (context, state) {
            return ItemCreateScreen(
              viewModel: context.read(),
            );
          },
        ),
        GoRoute(
          path: Routes.itemUpdate,
          builder: (context, state) {
            final Item item = state.extra as Item;
            return ItemUpdateScreen(
              viewModel: context.read(),
              item: item,
            );
          },
        ),
        GoRoute(
          path: Routes.transactionPayment,
          builder: (context, state) {
            return TransactionPaymentScreen(
              viewModel: context.read(),
            );
          },
        ),
        GoRoute(
          path: Routes.transactionPreview,
          builder: (context, state) {
            return TransactionPreviewScreen(
              viewModel: context.read(),
            );
          },
        ),
        GoRoute(
          path: Routes.transactionReceipt,
          builder: (context, state) {
            return TransactionReceiptScreen();
          },
        ),
        GoRoute(
          path: Routes.transactionList,
          builder: (context, state) {
            return TransactionListScreen(
              viewModel: context.read(),
            );
          },
        ),
        GoRoute(
          path: Routes.transactionDetail,
          builder: (context, state) {
            return TransactionDetailScreen();
          },
        ),
      ],
    ),
  ],
);
