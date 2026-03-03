import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/transaction/payment/view_model/transaction_payment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionPaymentScreen extends StatefulWidget {
  const TransactionPaymentScreen({
    super.key,
    required TransactionPaymentViewModel this.viewModel,
    required String this.clientId,
    required String this.type,
  });
  final TransactionPaymentViewModel viewModel;
  final String clientId;
  final String type;

  @override
  State<TransactionPaymentScreen> createState() =>
      _TransactionPaymentScreenState();
}

class _TransactionPaymentScreenState extends State<TransactionPaymentScreen> {
  String value = '';

  void updateValue(String newValue) {
    // 0 shouldn't be first
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
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              '${widget.viewModel.getTotalPrice(clientId: widget.clientId)}\$',
              style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white38),
            ),
            Spacer(),
            Text(
              '$value\$',
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 48.0,
            ),
            Container(
              height: 550.0,
              // color: Colors.amber,
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 35.0,
                crossAxisSpacing: 35.0,
                childAspectRatio: 0.25 / 0.25,
                physics: NeverScrollableScrollPhysics(),
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
            ),
            CustomButtonWidget(
              buttonText: 'Pay',
              onPressed: () {
                widget.viewModel.setTransactionDraftPayment(
                  clientId: widget.clientId,
                  value: double.parse(value.isEmpty ? '0' : value),
                );
                // clearValue();
                context.goNamed(
                  Routes.transactionPreviewName,
                  pathParameters: {'clientId': widget.clientId},
                  queryParameters: {'type': widget.type},
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton(
      {super.key, required String this.text, required this.onClick});
  final String text;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        // height: 70.0,
        // width: 70.0,
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
    );
  }
}
