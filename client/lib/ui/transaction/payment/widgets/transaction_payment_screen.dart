import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionPaymentScreen extends StatefulWidget {
  const TransactionPaymentScreen(
      {super.key, required TransactionCreateViewModel this.viewModel});
  final TransactionCreateViewModel viewModel;

  @override
  State<TransactionPaymentScreen> createState() =>
      _TransactionPaymentScreenState();
}

class _TransactionPaymentScreenState extends State<TransactionPaymentScreen> {
  String value = '';

  void updateValue(String newValue) {
    setState(() {
      value += newValue;
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
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: '8',
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: '7',
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: '6',
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: '5',
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: '4',
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: '3',
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: '2',
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: '1',
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: '.',
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: '0',
                    updateValue: updateValue,
                  ),
                  PaymentButton(
                    text: 'del',
                    updateValue: updateValue,
                  ),
                ],
              ),
            ),
            CustomButtonWidget(
              buttonText: 'Pay',
              onPressed: () {
                widget.viewModel.paid = 1230.0;
                context.push('/${Routes.transactionPreview}');
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
      {super.key, required String this.text, required this.updateValue});
  final String text;
  final Function(String) updateValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updateValue(text);
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
