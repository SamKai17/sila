import 'package:client/l10n/app_localizations.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionPaymentScreen extends ConsumerStatefulWidget {
  const TransactionPaymentScreen({
    super.key,
    required String this.clientId,
    required String this.type,
  });
  final String clientId;
  final String type;

  @override
  ConsumerState<TransactionPaymentScreen> createState() =>
      _TransactionPaymentScreenState();
}

class _TransactionPaymentScreenState
    extends ConsumerState<TransactionPaymentScreen> {
  String value = '';

  void updateValue(String newValue) {
    if (newValue == '0' && value.isEmpty) {
      return;
    }
    if (newValue == '.' && (value.contains('.') || value.isEmpty)) {
      return;
    }
    setState(() {
      value += newValue;
    });
  }

  void clearValue() {
    setState(() {
      value = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        ref.read(itemsCart(widget.clientId).notifier).totalPrice();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          spacing: 12.0,
          children: [
            Text(
              '\$${totalPrice}',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.w500,
                color: Colors.white38,
              ),
            ),
            Text(
              '$value\$',
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 48.0,
            ),
            Row(
              spacing: 12.0,
              children: [
                PaymentButton(
                  text: '9',
                  onClick: () => updateValue('9'),
                ),
                PaymentButton(
                  text: '8',
                  onClick: () => updateValue('8'),
                ),
                PaymentButton(
                  text: '7',
                  onClick: () => updateValue('7'),
                ),
              ],
            ),
            Row(
              spacing: 12.0,
              children: [
                PaymentButton(
                  text: '6',
                  onClick: () => updateValue('6'),
                ),
                PaymentButton(
                  text: '5',
                  onClick: () => updateValue('5'),
                ),
                PaymentButton(
                  text: '4',
                  onClick: () => updateValue('4'),
                ),
              ],
            ),
            Row(
              spacing: 12.0,
              children: [
                PaymentButton(
                  text: '3',
                  onClick: () => updateValue('3'),
                ),
                PaymentButton(
                  text: '2',
                  onClick: () => updateValue('2'),
                ),
                PaymentButton(
                  text: '1',
                  onClick: () => updateValue('1'),
                ),
              ],
            ),
            Row(
              spacing: 12.0,
              children: [
                PaymentButton(
                  text: '.',
                  onClick: () => updateValue('.'),
                ),
                PaymentButton(
                  text: '0',
                  onClick: () => updateValue('0'),
                ),
                PaymentButton(
                  text: 'del',
                  onClick: () => clearValue(),
                ),
              ],
            ),
            Spacer(),
            CustomButtonWidget(
              buttonText: AppLocalizations.of(context)!.pay,
              onPressed: () {
                double paid = double.parse(value.isEmpty ? '0' : value);
                context.pushNamed(
                  Routes.transactionPreviewName,
                  pathParameters: {
                    'clientId': widget.clientId,
                  },
                  queryParameters: {
                    'type': widget.type,
                  },
                  extra: paid,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    super.key,
    required String this.text,
    required this.onClick,
  });
  final String text;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          height: 110.0,
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontSize: 18.0),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: AppPallete.surface,
          ),
        ),
      ),
    );
  }
}
