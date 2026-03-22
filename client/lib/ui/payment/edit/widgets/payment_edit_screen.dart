import 'package:client/domain/models/payment/payment.dart';
import 'package:client/domain/models/transaction/transaction.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/payment/edit/view_model/payment_edit_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PaymentEditScreen extends ConsumerStatefulWidget {
  const PaymentEditScreen({
    super.key,
    required Transaction this.transaction,
    required Payment this.payment,
  });
  final Payment payment;
  final Transaction transaction;

  @override
  ConsumerState<PaymentEditScreen> createState() => _PaymentEditScreenState();
}

class _PaymentEditScreenState extends ConsumerState<PaymentEditScreen> {
  late String value;

  @override
  void initState() {
    value = widget.payment.amount.toString();
    super.initState();
  }

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
    ref.listen(
      paymentEditViewModel,
      (previous, next) {
        next.when(
          data: (data) {
            if (context.mounted) {
              context.pop();
            }
          },
          error: (error, stackTrace) {},
          loading: () {},
        );
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            // Text(
            //   '\$${widget.payment.amount}',
            //   style: TextStyle(
            //     fontSize: 36.0,
            //     fontWeight: FontWeight.w500,
            //     color: Colors.white38,
            //   ),
            // ),
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
              buttonText: 'Save',
              onPressed: () async {
                double paid = double.parse(value.isEmpty ? '0' : value);
                await ref.read(paymentEditViewModel.notifier).updatePayment(
                      transaction: widget.transaction,
                      payment: widget.payment,
                      newAmount: paid,
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
