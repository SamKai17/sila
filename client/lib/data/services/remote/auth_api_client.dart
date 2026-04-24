import 'dart:async';
import 'package:client/utils/constants.dart';
import 'package:client/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authApiClient = Provider(
  (ref) {
    return AuthApiClient();
  },
);

final sendCodeNotification = StreamProvider.autoDispose<Result<String>>(
  (ref) {
    return ref.read(authApiClient).observeCode;
  },
);

class AuthApiClient {
  String? _id;
  final StreamController<Result<String>> _controller =
      StreamController.broadcast();
  Stream<Result<String>> get observeCode => _controller.stream;

  Future<Result<User?>> login({
    required String smsCode,
  }) async {
    try {
      if (_id == null) {
        return Result.error(Exception('code not sent yet'));
      }
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: _id!, smsCode: smsCode);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential.user);
      return Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  Future<void> sendCode({
    required String phoneNumber,
  }) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // print('success');
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          _controller.addError(e);
          // _controller.add(Result.error(e));
          print('failed');
          // ScaffoldMessenger.of(context).showSnackBar(
          // SnackBar(content: Text('an error happened')));
        },
        codeSent: (String verificationId, int? resendToken) {
          _controller.add(Result.ok(verificationId));
          _id = verificationId;
          // print('code sent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // print('timeout');
        },
      );
      // return Result.ok(null);
    } on FirebaseAuthException catch (e) {
      _controller.addError(e);
      // return Result.error(e);
    }
  }

  Future<Result<void>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
}
