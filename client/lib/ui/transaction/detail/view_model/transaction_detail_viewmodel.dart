import 'dart:async';
import 'dart:io';
import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

final transactionDetailViewModel =
    AsyncNotifierProvider<TransactionDetailViewModel, void>(
        TransactionDetailViewModel.new);

class TransactionDetailViewModel extends AsyncNotifier<void> {
  TransactionDetailViewModel();
  @override
  FutureOr<void> build() {
    _transactionRepository = ref.read(transactionRepository);
  }

  late TransactionRepository _transactionRepository;

  Future<void> deletePayments({
    required Transaction transaction,
  }) async {
    try {
      state = AsyncValue.loading();
      final selectedPaymentsList = ref.read(selectedPayments);
      final ids = selectedPaymentsList.map((payment) => payment.id).toList();
      final result = await _transactionRepository.deletePayments(
        paymentsIds: ids,
        transaction: transaction,
      );
      switch (result) {
        case Ok():
          state = AsyncValue.data(null);
        case Error():
          state = AsyncValue.error(result.error, StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> shareTransaction(GlobalKey boudaryKey) async {
    try {
      print('sharing');
      final context = boudaryKey.currentContext;
      if (context == null) return;
      final renderObject = context.findRenderObject();
      if (renderObject is! RenderRepaintBoundary) return;
      if (renderObject.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
        return shareTransaction(boudaryKey);
      }
      final ui.Image image = await renderObject.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final byteDataAsUint8 = byteData?.buffer.asUint8List();
      if (byteDataAsUint8 == null) return;
      final tempDir = await getTemporaryDirectory();
      final path =
          '${tempDir.path}/quote_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(path);
      await file.writeAsBytes(byteDataAsUint8, flush: true);
      print('here: ${file.path}');
      final params =
          ShareParams(files: [XFile(file.path)], text: 'sharing a transaction');
      await SharePlus.instance.share(params);
      print('success');
    } catch (e) {
      print('exceppptioon: ${e}');
    }
  }
}

final isPaymentselected = Provider.family(
  (ref, Payment payment) {
    final _selectedPayments = ref.watch(selectedPayments);
    return _selectedPayments.contains(payment);
  },
);

final paymentselectedMode = Provider(
  (ref) {
    final _selectedPayments = ref.watch(selectedPayments);
    return _selectedPayments.isNotEmpty;
  },
);

final selectedPayments =
    NotifierProvider<SelectedPayments, List<Payment>>(SelectedPayments.new);

class SelectedPayments extends Notifier<List<Payment>> {
  @override
  List<Payment> build() {
    return [];
  }

  void addSelectedPayment(Payment payment) {
    state = [...state, payment];
  }

  void removeSelectedPayment(Payment payment) {
    final newList = [...state];
    newList.remove(payment);
    state = newList;
  }

  void clearSelectedPayments() {
    state = [];
  }
}
