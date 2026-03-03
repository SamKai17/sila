import 'package:client/data/repositories/transaction/transaction_draft_repository.dart';
import 'package:flutter/material.dart';

class TransactionPaymentViewModel extends ChangeNotifier {
  TransactionPaymentViewModel({
    required TransactionDraftRepository transactionDraftRepository,
  }) : _transactionDraftRepository = transactionDraftRepository {}

  final TransactionDraftRepository _transactionDraftRepository;

  double getTotalPrice({required String clientId}) {
    return _transactionDraftRepository.getTotalPrice(clientId: clientId);
  }

  void setTransactionDraftPayment({
    required String clientId,
    required double value,
  }) {
    _transactionDraftRepository.setTransactionDraftPayment(
      clientId: clientId,
      value: value,
    );
  }
}