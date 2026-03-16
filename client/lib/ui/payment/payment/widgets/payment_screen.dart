import 'package:client/data/repositories/transaction/transaction_repository.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:client/ui/payment/payment/view_model/payment_viewmodel.dart';
import 'package:client/ui/transaction/detail/view_model/transaction_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({
    super.key,
    required String this.transactionId,
    required String this.clientId,
  });
  final String clientId;
  final String transactionId;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
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
    final transactionAsync =
        ref.watch(transactionProvider(widget.transactionId));
    return Scaffold(
      appBar: AppBar(),
      body: transactionAsync.when(
        data: (transaction) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  '\$${transaction.remainder}',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white38,
                  ),
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
                    double paid = double.parse(value.isEmpty ? '0' : value);
                    context.pushNamed(
                      Routes.paymentPreviewName,
                      queryParameters: {
                        'clientId': widget.clientId,
                        'transactionId': widget.transactionId,
                      },
                      extra: paid,
                    );
                  },
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('hello'),
          );
        },
        loading: () {
          return Center(
            child: LoaderWidget(),
          );
        },
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
