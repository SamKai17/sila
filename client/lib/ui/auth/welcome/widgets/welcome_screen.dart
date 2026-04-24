import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Welcome To Sila App',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            CustomButtonWidget(
              buttonText: 'Next',
              onPressed: () {
                context.pushNamed(Routes.loginName);
              },
            )
          ],
        ),
      ),
    );
  }
}
