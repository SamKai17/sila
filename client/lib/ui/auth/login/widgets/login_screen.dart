import 'package:client/ui/auth/login/view_model/auth_viewmodel.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _phoneController =
      TextEditingController(text: '+212');
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authViewModel,
      (previous, next) {
        next.when(
          data: (data) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('success logging in!')));
          },
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('an error happened')));
          },
          loading: () {},
        );
      },
    );
    final isLoading = ref.watch(authViewModel).isLoading;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: isLoading
            ? LoaderWidget()
            : Form(
                child: Column(
                  children: [
                    // CustomFieldWidget(
                    // hintText: 'phone number', controller: _phoneController),
                    // CountryCodePicker(),
                    CustomFieldWidget(
                      hintText: 'Phone',
                      controller: _phoneController,
                    ),
                    SizedBox(height: 32.0),
                    // IntlPhoneField(
                    //   initialCountryCode: 'MA',
                    //   dropdownDecoration: BoxDecoration(),
                    //   controller: _phoneController,
                    // ),
                    CustomButtonWidget(
                      buttonText: 'send OTP',
                      onPressed: () async {
                        await ref
                            .read(authViewModel.notifier)
                            .sendCode(phoneNumber: _phoneController.text);
                      },
                    ),
                    SizedBox(height: 32.0),
                    CustomFieldWidget(
                      hintText: 'code',
                      controller: _codeController,
                    ),
                    SizedBox(height: 32.0),
                    CustomButtonWidget(
                      buttonText: 'Verify',
                      onPressed: () async {
                        await ref
                            .read(authViewModel.notifier)
                            .login(smsCode: _codeController.text);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
