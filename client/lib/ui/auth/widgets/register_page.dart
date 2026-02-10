import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader_widget.dart';
import 'package:client/core/widgets/custom_button_widget.dart';
import 'package:client/core/widgets/custom_field_widget.dart';
import 'package:client/ui/auth/view_models/auth_viewmodel.dart';
import 'package:client/ui/client/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
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
    final isLoading = ref.watch(
      authProvider.select((value) => value.isLoading),
    );
    ref.listen(authProvider, (_, next) {
      next.when(
        data: (data) {
          showSnackBar(context, "Account created Successfully!");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
            (route) => false,
          );
        },
        error: (error, stackTrace) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text("Registration")),
      body: isLoading
          ? LoaderWidget()
          : Padding(
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(authProvider.notifier)
                              .register(
                                username: usernameController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                              );
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
