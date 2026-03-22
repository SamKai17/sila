import 'package:client/routing/routes.dart';
import 'package:client/ui/auth/login/view_model/auth_viewmodel.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      loginViewModel,
      (previous, next) {
        next.when(
          data: (data) {
            if (context.mounted) {
              context.goNamed(Routes.homeName);
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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sila", style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(height: 32.0),
              CustomFieldWidget(
                hintText: "Username",
                controller: _usernameController,
              ),
              SizedBox(height: 24.0),
              CustomFieldWidget(
                hintText: "Password",
                controller: _passwordController,
                isObscureText: true,
              ),
              SizedBox(height: 32.0),
              CustomButtonWidget(
                buttonText: "Login",
                onPressed: () async {
                  await ref.read(loginViewModel.notifier).login(
                      username: _usernameController.text,
                      password: _passwordController.text);
                },
              ),
              SizedBox(height: 32.0),
              RichText(text: TextSpan(text: "Don’t have an account?")),
              SizedBox(height: 12.0),
              CustomButtonWidget(
                buttonText: "Register",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
