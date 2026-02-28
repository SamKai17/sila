import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionReceiptScreen extends StatelessWidget {
  const TransactionReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Spacer(),
            CustomButtonWidget(
              buttonText: 'View Transaction',
              onPressed: () {
                context.pop();
              },
            ),
            SizedBox(height: 12.0),
            CustomButtonWidget(
              buttonText: 'Share',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
