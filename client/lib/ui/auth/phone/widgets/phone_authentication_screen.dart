import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneAuthenticationScreen extends StatefulWidget {
  const PhoneAuthenticationScreen({super.key});

  @override
  State<PhoneAuthenticationScreen> createState() =>
      _PhoneAuthenticationScreenState();
}

class _PhoneAuthenticationScreenState extends State<PhoneAuthenticationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  late String _verificationId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
            child: Column(
          children: [
            // CustomFieldWidget(
            // hintText: 'phone number', controller: _phoneController),
            // CountryCodePicker(),
            IntlPhoneField(
              initialCountryCode: 'MA',
              dropdownDecoration: BoxDecoration(),
              controller: _phoneController,
            ),
            CustomButtonWidget(
              buttonText: 'send OTP',
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '+212 6 61 62 09 09',
                  verificationCompleted: (PhoneAuthCredential credential) {
                    print('success');
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    print('failed');
                  },
                  codeSent: (String verificationId, int? resendToken) {
                    // context.pushNamed(Routes.codeVerificationName,
                    // extra: verificationId);
                    _verificationId = verificationId;
                    print('phone: ${_phoneController.text}');
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('code sent')));
                    print('code sent');
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {
                    print('timeout');
                  },
                );
              },
            ),
            SizedBox(height: 32.0),
            CustomFieldWidget(hintText: 'code', controller: _codeController),
            SizedBox(height: 32.0),
            CustomButtonWidget(
              buttonText: 'Verify',
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: _verificationId,
                    smsCode: _codeController.text);
                final userCredential = await FirebaseAuth.instance
                    .signInWithCredential(credential);
                print(userCredential.user?.displayName);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('successful login')));
              },
            ),
          ],
        )),
      ),
    );
  }
}
