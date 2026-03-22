import 'package:client/domain/models/payment/payment.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/information_card.dart';
import 'package:client/ui/transaction/detail/view_model/transaction_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PaymentCard extends ConsumerWidget {
  const PaymentCard({
    super.key,
    required Payment this.payment,
    required Transaction this.transaction,
    required String this.clientId,
  });

  final Payment payment;
  final String clientId;
  final Transaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(isPaymentselected(payment));
    final selectedMode = ref.watch(paymentselectedMode);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onLongPress: () {
          if (isSelected) {
            ref.read(selectedPayments.notifier).removeSelectedPayment(payment);
          } else {
            ref.read(selectedPayments.notifier).addSelectedPayment(payment);
          }
        },
        onTap: () {
          if (selectedMode) {
            if (isSelected) {
              ref
                  .read(selectedPayments.notifier)
                  .removeSelectedPayment(payment);
            } else {
              ref.read(selectedPayments.notifier).addSelectedPayment(payment);
            }
          } else {
            context.pushNamed(Routes.paymentEditName, pathParameters: {
              'clientId': clientId,
              'transactionId': transaction.id,
            }, extra: {
              'transaction': transaction,
              'payment': payment
            });
          }
        },
        child: InformationCard(
          information: {
            'Payment Date':
                '${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(payment.timeOfPayment))}',
            'Paid': '${payment.amount}\$',
          },
          isSelected: isSelected,
          selectedMode: selectedMode,
        ),
      ),
    );
  }
}