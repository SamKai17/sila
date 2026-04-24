import 'package:client/routing/routes.dart';
import 'package:client/ui/auth/login/view_model/auth_viewmodel.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
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
              CustomButtonWidget(
                buttonText: "Register",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    // await ref.read(loginViewModel.notifier).register(
                    //       username: usernameController.text,
                    //       password: passwordController.text,
                    //       confirmPassword: passwordController.text,
                    //     );
                    context.goNamed(Routes.loginName);
                    // context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
