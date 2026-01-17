import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader_widget.dart';
import 'package:client/features/auth/view/widgets/auth_button_widget.dart';
import 'package:client/features/auth/view/widgets/custom_field_widget.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/home_page.dart';
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
      authNotifierProvider.select((value) => value.isLoading,),
    );
    ref.listen(authNotifierProvider, (_, next) {
      next.when(
        data: (data) {
          print("register page");
          showSnackBar(context, "Account created Successfully!");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
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
                    AuthButtonWidget(
                      buttonText: "Register",
                      onPressed: () {
                        ref
                            .read(authNotifierProvider.notifier)
                            .register(
                              username: usernameController.text,
                              password: passwordController.text,
                            );
                      },
                    ),
                    // SizedBox(height: 32.0),
                    // RichText(text: TextSpan(text: "Already have an account?")),
                  ],
                ),
              ),
            ),
    );
  }
}
