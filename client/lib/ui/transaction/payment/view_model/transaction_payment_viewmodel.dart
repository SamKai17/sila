import 'package:client/data/repositories/transaction/transaction_draft_repository.dart';
import 'package:flutter/material.dart';

class TransactionPaymentViewModel extends ChangeNotifier {
  TransactionPaymentViewModel({
    // required TransactionRepository transactionRepository,
    required TransactionDraftRepository transactionDraftRepository,
  }) : _transactionDraftRepository = transactionDraftRepository {
    // load = Command1<void, String>(_load);
  }
  // final TransactionRepository _transactionRepository;

  final TransactionDraftRepository _transactionDraftRepository;

  double totalPrice = 0.0;

  void setTransactionDraftPayment(
      {required String clientId, required double value}) {
    _transactionDraftRepository.setTransactionDraftPayment(
      clientId: clientId,
      value: value,
    );
  }
}