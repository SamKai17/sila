import 'package:client/features/auth/view/widgets/auth_button_widget.dart';
import 'package:client/features/auth/view/widgets/custom_field_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create a free account",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 32.0),
              CustomFieldWidget(
                hintText: "Username",
                controller: usernameController,
              ),
              SizedBox(height: 24.0),
              CustomFieldWidget(
                hintText: "Password",
                controller: passwordController,
                isObscureText: true,
              ),
              SizedBox(height: 24.0),
              CustomFieldWidget(
                hintText: "Confirm Password",
                controller: confirmPasswordController,
                isObscureText: true,
              ),
              SizedBox(height: 32.0),
              AuthButtonWidget(buttonText: "Register", onPressed: () {}),
              // SizedBox(height: 32.0),
              // RichText(text: TextSpan(text: "Already have an account?")),
            ],
          ),
        ),
      ),
    );
  }
}
