import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/data/repositories/transaction/transaction_draft_repository.dart';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/data/services/local/database_service.dart';
import 'package:client/routing/router.dart';
import 'package:client/ui/client/create/view_model/client_create_viewmodel.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/ui/client/update/view_model/client_update_viewmodel.dart';
import 'package:client/ui/core/theme/app_theme.dart';
import 'package:client/ui/payment/payment/view_model/payment_viewmodel.dart';
import 'package:client/ui/payment/preview/view_model/payment_preview_viewmodel.dart';
import 'package:client/ui/payment/receipt/view_model/payment_receipt_viewmodel.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:client/ui/transaction/detail/view_model/transaction_detail_viewmodel.dart';
import 'package:client/ui/transaction/list/view_model/transactions_viewmodel.dart';
import 'package:client/ui/transaction/payment/view_model/transaction_payment_viewmodel.dart';
import 'package:client/ui/transaction/preview/view_model/transaction_preview_viewmodel.dart';
import 'package:client/ui/transaction/receipt/view_model/transaction_receipt_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // MultiProvider(
    //   providers: [
    //     Provider(
    //       create: (context) => DatabaseService(),
    //     ),
    //     Provider(
    //       create: (context) =>
    //           ClientRepository(databaseService: context.read()),
    //     ),
    //     Provider(
    //       create: (context) =>
    //           TransactionRepository(databaseService: context.read()),
    //     ),
    //     Provider(
    //       create: (context) =>
    //           TransactionDraftRepository(databaseService: context.read()),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) => HomeViewModel(clientRepository: context.read()),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) =>
    //           ClientDetailViewModel(clientRepository: context.read()),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) =>
    //           ClientUpdateViewModel(clientRepository: context.read()),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) => ClientCreateViewModel(
    //         clientRepository: context.read(),
    //       ),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) => TransactionCreateViewModel(
    //         transactionDraftRepository: context.read(),
    //       ),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) =>
    //           TransactionsViewModel(transactionRepository: context.read()),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) =>
    //           TransactionDetailViewModel(transactionRepository: context.read()),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) => TransactionPaymentViewModel(
    //         // transactionRepository: context.read(),
    //         transactionDraftRepository: context.read(),
    //       ),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) => TransactionPreviewViewModel(
    //         transactionRepository: context.read(),
    //         transactionDraftRepository: context.read(),
    //       ),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) => TransactionReceiptViewModel(
    //         transactionRepository: context.read(),
    //       ),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) => PaymentViewModel(
    //         transactionRepository: context.read(),
    //       ),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) => PaymentPreviewViewModel(
    //         transactionRepository: context.read(),
    //       ),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) => PaymentReceiptViewModel(
    //         transactionRepository: context.read(),
    //       ),
    //     )
    //   ],
      ProviderScope(child: const MyApp()),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sila',
      theme: AppTheme.darkThemeMode,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(
            overscroll: false,
          ),
          child: child!,
        );
      },
    );
  }
}
