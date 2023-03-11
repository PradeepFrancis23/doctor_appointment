import 'dart:async';
import 'dart:convert';

import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_bloc.dart';
import 'package:doctor_appointment/screens/auth_screens/login_screen.dart';
import 'package:doctor_appointment/services/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  RoundedLoadingButtonController signUpbutnController =
      RoundedLoadingButtonController();
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  SharedPreferences? _sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    initializedGetSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an Account,Its free",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _signupFormKey,
                  child: Column(
                    children: [
                      makeInput(
                          label: "Full Name",
                          controller: fullnamecontroller,
                          validator: (value) {
                            if (fullnamecontroller.text.isEmpty) {
                              return "Enter Valid Name";
                            }
                          }),
                      makeInput(
                          label: "Phone Number",
                          controller: phonenumber,
                          validator: (value) {
                            if (phonenumber.text.isEmpty) {
                              return 'Enter Valida Phone Number';
                            }
                          }),
                      makeInput(
                          label: "Email",
                          controller: emailController,
                          validator: (value) {
                            if (emailController.text.isEmpty) {
                              print('email emty');
                              return 'Enter valid Email';
                            }
                          }),
                      makeInput(
                          label: "Password",
                          obsureText: true,
                          controller: passwordController,
                          validator: (value) {
                            if (passwordController.text.isEmpty) {
                              return 'Enter Valid Password';
                            }
                          }),
                      makeInput(
                          label: "Confirm Pasword",
                          obsureText: true,
                          controller: confirmpasswordController,
                          validator: (value) {
                            if (confirmpasswordController.text.isEmpty) {
                              return 'Enter Valid Confirm Password';
                            }
                          })
                    ],
                  ),
                ),
              ),
              RoundedLoadingButton(
                  color: Colors.redAccent,
                  controller: signUpbutnController,
                  onPressed: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      print("Created Acct");
                      _submit();
                      storeSignupData();
                      signUpbutnController.reset();
                    }).onError((error, stackTrace) {
                      print("${error.toString()}");
                    });
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(
                                  address: '',
                                  email: emailController.text,
                                  fullname: fullnamecontroller.text,
                                  password: passwordController.text,
                                )),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                      address: '',
                                      email: emailController.text,
                                      fullname: fullnamecontroller.text,
                                      password: passwordController.text,
                                    )),
                            (route) => false);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void storeSignupData() {
    UserSignupModel userSignupModel = UserSignupModel(
        fullnamecontroller.text,
        phonenumber.text,
        emailController.text,
        passwordController.text,
        confirmpasswordController.text);
    // this wiil store input data in json format and encode it
    String usersignupDataJsonEncoding = jsonEncode(userSignupModel);
    print(usersignupDataJsonEncoding);
    _sharedPreferences?.setString(
        'userDataJsonEncoding', usersignupDataJsonEncoding);
  }

  void _submit() {
    final isValid = _signupFormKey.currentState!.validate();
    if (_signupFormKey.currentState!.validate()) {
      print('0');
      Timer(const Duration(milliseconds: 15), () {
        print('1');
        signUpbutnController.success();
        _signupFormKey.currentState!.save();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => LoginBloc(),
                      child: LoginScreen(
                        address: '',
                        email: emailController.text,
                        fullname: fullnamecontroller.text,
                        password: passwordController.text,
                      ),
                    )),
            (route) => false);
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User Registered")));
      signUpbutnController.reset();
    } else {
      print('2');
      Timer(const Duration(milliseconds: 15), () {
        signUpbutnController.error();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid Data")));
        signUpbutnController.reset();
      });
    }
    print('3');
    _signupFormKey.currentState!.save();
  }
}

void initializedGetSavedData() {}

Widget makeInput({label, obsureText = false, controller, validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obsureText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}

extension Extstring on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidConfirmPassword {
    final confirmPassRegex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return confirmPassRegex.hasMatch(this);
  }
}
