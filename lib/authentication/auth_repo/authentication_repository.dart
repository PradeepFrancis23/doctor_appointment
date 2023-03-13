import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

// import 'package:path/path.dart' as Path;

class AuthenticationRepository {
  final _auth = FirebaseAuth.instance;
  var verificationId = "";

  Future<void> phoneAuthentication(String phoneNumber, context) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == "invalid-phone-number") {
            // TODO context
            print(e.toString());
            print('err1');
            //  ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(content: Text("Error,Number Invalid")));
          } else {
            print(e.toString());
            print('2');
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
