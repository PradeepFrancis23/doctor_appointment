import 'dart:async';
import 'dart:convert';

import 'package:doctor_appointment/screens/all_home_screens/main_home_screen.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_bloc.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_event.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_state.dart';
import 'package:doctor_appointment/screens/auth_screens/signup_screen.dart';
import 'package:doctor_appointment/screens/password_auth/otp_verification_screen.dart';
import 'package:doctor_appointment/screens/patients_info/pateint_credentials.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:doctor_appointment/services/users.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  final String fullname;
  final String address;
  final String email;
  final String password;

  const LoginScreen(
      {super.key,
      required this.fullname,
      required this.address,
      required this.email,
      required this.password});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  RoundedLoadingButtonController loginbutnController =
      RoundedLoadingButtonController();

  SharedPreferences? _sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin();

    // initializedGetSavedData('');
  }

  void checklogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");

    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const PatientCredentials(
                    email: '',
                  )),
          (route) => false);
    }
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Column(
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome back ! Login with your credentials",
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
                    key: _formKey,
                    child: Column(
                      children: [
                        BlocBuilder<LoginBloc, SignInState>(
                          builder: (context, state) {
                            if (state is ErrorState) {
                              return const Text(
                                "Please Enter Valid Email !!",
                                style: TextStyle(color: Colors.red),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        makeInput(
                            label: "Email",
                            controller: emailController,
                            onchanged: (val) {
                              if (emailController.text == widget.email) {
                                BlocProvider.of<LoginBloc>(context).add(
                                    SignInTextChangingEvent(
                                        emailController.text,
                                        passwordController.text));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('InValid Email')));
                              }
                            }),
                        makeInput(
                            label: "Password",
                            obsureText: true,
                            controller: passwordController,
                            onchanged: (val) {
                              if (passwordController.text == widget.password) {
                                BlocProvider.of<LoginBloc>(context).add(
                                    SignInTextChangingEvent(
                                        emailController.text,
                                        passwordController.text));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('InValid Password')));
                              }
                            }),
                      ],
                    ),
                  ),
                ),

                BlocBuilder<LoginBloc, SignInState>(
                  builder: (context, state) {
                    // TODO WOrk on success indiactor and error incdicator
                    // if (state is SigninLoadingState) {
                    //   loginbutnController.start();
                    // }

                    return RoundedLoadingButton(
                        successColor: Colors.green,
                        successIcon: Icons.check,
                        errorColor: Colors.red,
                        failedIcon: Icons.close,
                        color: (state is ValidState)
                            ? Colors.indigoAccent[400]
                            : Colors.grey,
                        controller: loginbutnController,
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(
                              SignInSubmittedEvent(emailController.text,
                                  passwordController.text));
                          if (state is ValidState &&
                              _formKey.currentState!.validate()) {
                            Timer(const Duration(milliseconds: 15), () {
                              loginbutnController.success();
                              storeloginData();

                              print('0');
                            });
                          } else if (state is InvalidState) {
                            print('2');
                            Timer(const Duration(milliseconds: 15), () {
                              loginbutnController.error();
                              loginbutnController.reset();
                            });
                          }
                          print('3');
                          loginbutnController.reset();
                        },
                        child: const Text(
                          "login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white70),
                        ));
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Dont have an account?  "),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                            (route) => false);
                      },
                      child: const Text(
                        "Signup",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // forgot password
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Stack(
                              clipBehavior: Clip.none,
                              children: <Widget>[
                                Positioned(
                                  right: -40.0,
                                  top: -40.0,
                                  child: InkResponse(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                              controller:
                                                  _phoneNumberController,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: const InputDecoration(
                                                  labelText: "Phone Number ",
                                                  // hintText:
                                                  //     "Add your phone Number",
                                                  icon: Icon(
                                                      Icons.phone_iphone)))),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          child: const Text("Send OTP"),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const OTPVerification()),
                                                    (route) => false);

                                            // if (_phoneNumberController
                                            //             .text.length !=
                                            //         10 ||
                                            //     _phoneNumberController.text
                                            //         .startsWith(
                                            //             RegExp(r'[0-5]'))) {
                                            //   Future.delayed(
                                            //       Duration(milliseconds: 2000),
                                            //       () {
                                            //     EasyLoading.showError('Oops!!',
                                            //         duration: const Duration(
                                            //             milliseconds: 1500));
                                            //     ScaffoldMessenger.of(context)
                                            //         .showSnackBar(const SnackBar(
                                            //             content: Text(
                                            //                 "Enter Valid Number")));
                                            //   });
                                            // } else {
                                            //   EasyLoading.show(
                                            //       status: 'loading');
                                            //   _otpSend(
                                            //       _phoneNumberController.text);
                                            // }
                                            // EasyLoading.dismiss();
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle(
                        fontSize: 13, color: Color.fromARGB(255, 19, 19, 216)),
                  ),
                ),
                // const Text(
                //   'Forgot Password ?',
                //   style: TextStyle(
                //       fontSize: 13, color: Color.fromARGB(255, 19, 19, 216)),
                // ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void storeloginData() async {
    // if(emailController.textzz && passwordController.text.isNotEmpty){

    // }
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var response = await http.post(Uri.parse("https://reqres.in/api/login"),
          body: ({
            "email": emailController.text,
            "password": passwordController.text
          }));
      if (response.statusCode == 200) {
        // success code
        final body = jsonDecode(response.body);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Token : ${body['token']}")));
        initializedGetSavedData(body['token']);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid Crendentials")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Blank Value Found')));
    }
  }

  void initializedGetSavedData(String token) async {
    // we store val or token inside sharepref
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('login', token);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  address: '',
                  email: emailController.text,
                  fullname: '',
                )),
        (route) => false);
    // _sharedPreferences = await SharedPreferences.getInstance();
  }

  // Method to validate the email the take
// the user email as an input and
// print the bool value in the console.
  // void Validate(String email) {
  //   bool isvalid = EmailValidator.validate(email);
  // }
}

void _otpSend(String mobileNumber) {
  // TODO
}

Widget makeInput({label, obsureText = false, controller, onchanged}) {
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
      TextField(
        onChanged: onchanged,
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
      ),
    ],
  );
}
