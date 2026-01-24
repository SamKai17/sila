import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader_widget.dart';
import 'package:client/features/auth/view/pages/register_page.dart';
import 'package:client/features/auth/view/widgets/auth_button_widget.dart';
import 'package:client/features/auth/view/widgets/custom_field_widget.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/client/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
    final isLoading = ref.watch(
      authProvider.select((value) => value.isLoading),
    );
    ref.listen(authProvider, (_, next) {
      next.when(
        data: (data) {
          print("login page");
          showSnackBar(context, "Successfully logged in!");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        },
        error: (error, stackTrace) {
          showSnackBar(context, "error login, wrong username or password!");
        },
        loading: () {},
      );
    });
    return Scaffold(
      appBar: AppBar(),
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
                      "Sila",
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
                    SizedBox(height: 32.0),
                    AuthButtonWidget(
                      buttonText: "Login",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(authProvider.notifier)
                              .login(
                                username: usernameController.text,
                                password: passwordController.text,
                              );
                        }
                      },
                    ),
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
