import 'package:client/features/auth/view/pages/register_page.dart';
import 'package:client/features/auth/view/widgets/auth_button_widget.dart';
import 'package:client/features/auth/view/widgets/custom_field_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sila", style: Theme.of(context).textTheme.headlineLarge),
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
              SizedBox(height: 32.0),
              AuthButtonWidget(buttonText: "Login", onPressed: () {}),
              SizedBox(height: 32.0),
              RichText(text: TextSpan(text: "Don’t have an account?")),
              SizedBox(height: 12.0),
              AuthButtonWidget(
                buttonText: "Register",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RegisterPage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
