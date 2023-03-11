import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

// import 'package:path/path.dart' as Path;

class AuthenticationRepository {
  final _auth = FirebaseAuth.instance;
  var verificationId = "";

  Future<void> phoneAuthentication(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == "invalid-phone-number") {
                // TODO context
            // ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text("Error,Number Invalid")));
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text("Something Went Wrong")));
          }
        },
        codeSent: ((verificationId, resendToken) {
          this.verificationId = verificationId;
        }),
        codeAutoRetrievalTimeout: ((verificationId) {
          this.verificationId = verificationId;
        }));
  }

  Future<bool> verifyOtp(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            smsCode: otp, verificationId: verificationId));
    return credentials.user != null ? true : false;
  }
}
