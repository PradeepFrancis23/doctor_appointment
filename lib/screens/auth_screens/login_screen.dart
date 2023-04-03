import 'dart:async';

import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:doctor_appointment/authentication/controllers/login_controllers.dart';
import 'package:doctor_appointment/bloc/login/login_state.dart';
import 'package:doctor_appointment/screens/all_home_screens/main_home_screen.dart';
import 'package:doctor_appointment/screens/auth_screens/home_login_signup.dart';

import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_bloc.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_event.dart';
import 'package:doctor_appointment/screens/auth_screens/login_bloc/login_state.dart';
import 'package:doctor_appointment/screens/auth_screens/signup_bloc/signup_bloc.dart';
import 'package:doctor_appointment/screens/auth_screens/signup_screen.dart';
import 'package:doctor_appointment/screens/password_auth/otp_verification_screen.dart';
import 'package:doctor_appointment/screens/patients_info/pateint_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:flutter/material.dart';

// import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isDarkModeEnabled = false;
  final _formKey = GlobalKey<FormState>();
  final controllers = LogInControllers();

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
      // ignore: use_build_context_synchronously
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
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Color(0xff253341)),
        scaffoldBackgroundColor: Color.fromARGB(255, 6, 8, 9),
      ),
      themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.white,
        // appBar: AppBar(
        //   // actions: [
        //   //   DayNightSwitcher(
        //   //     isDarkModeEnabled: isDarkModeEnabled,
        //   //     onStateChanged: onStateChanged,
        //   //   ),
        //   // ],
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   // brightness: Brightness.light,
        //   // backgroundColor: Colors.white,
        //   // TODO add leading
        //   // leading: IconButton(
        //   //     onPressed: () {
        //   //       Navigator.pop(context);
        //   //     },
        //   //     icon: const Icon(
        //   //       Icons.arrow_back_ios,
        //   //       size: 20,
        //   //       color: Colors.black,
        //   //     )),
        // ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: ListView(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Column(
                      children: [
                        DayNightSwitcherIcon(
                            isDarkModeEnabled: isDarkModeEnabled,
                            onStateChanged: onStateChanged),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                  return Text(
                                    state.errorMessage,
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
                                colors: isDarkModeEnabled
                                    ? Color.fromARGB(255, 246, 247, 248)
                                    : Colors.black,
                                controller: controllers.emailController,
                                onchanged: (val) {
                                  // if (emailController.text == widget.email) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      SignInTextChangingEvent(
                                          controllers.emailController.text,
                                          controllers.passwordController.text));
                                  // } else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //       const SnackBar(
                                  //           content: Text('InValid Email')));
                                  // }
                                }),
                            makeInput(
                                label: "Password",
                                colors: isDarkModeEnabled
                                    ? const Color.fromARGB(255, 246, 247, 248)
                                    : Colors.black,
                                obsureText: true,
                                controller: controllers.passwordController,
                                onchanged: (val) {
                                  // if (passwordController.text == widget.password) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      SignInTextChangingEvent(
                                          controllers.emailController.text,
                                          controllers.passwordController.text));
                                  // } else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //       const SnackBar(
                                  //           content: Text('InValid Password')));
                                  // }
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
                            controller: controllers.loginbutnController,
                            onPressed: () {
                              // progrees indiactor
                              // controllers.loginbutnController.
                              try {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: controllers.emailController.text,
                                        password:
                                            controllers.passwordController.text)
                                    .then((value) {
                                  print("logged in");
                                  BlocProvider.of<LoginBloc>(context).add(
                                      SignInSubmittedEvent(
                                          controllers.emailController.text,
                                          controllers.passwordController.text));
                                  if (state is ValidState &&
                                      _formKey.currentState!.validate()) {
                                    Timer(const Duration(milliseconds: 15), () {
                                      controllers.loginbutnController.success();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                    email: controllers
                                                        .emailController.text,
                                                    fullname: "fullname",
                                                    address: "address",
                                                    password: controllers
                                                        .passwordController
                                                        .text,
                                                  )));
                                    });
                                  } else if (state is InvalidState) {
                                    print('2');
                                    Timer(const Duration(milliseconds: 15), () {
                                      controllers.loginbutnController.error();
                                      controllers.loginbutnController.reset();
                                    });
                                  }
                                  print('3');
                                  controllers.loginbutnController.reset();
                                }).onError((error, stackTrace) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(error.toString())));
                                  controllers.loginbutnController.reset();
                                  print('err');
                                });
                              } catch (e) {
                                print('caught');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("$e")));
                                controllers.loginbutnController.reset();
                              }
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Dont have an account?  "),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => SingUpBloc(),
                                          child: SignupScreen(),
                                        )),
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
                                          // if (_formKey.currentState!.validate()) {
                                          print('sendotp');
                                          controllers.instancePhoneAuth
                                              .phoneAuthentication(
                                                  controllers
                                                      .phoneNumberController
                                                      .text
                                                      .trim(),
                                                  context);
                                          // }
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                    ),
                                    Form(
                                      // key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  controller: controllers
                                                      .phoneNumberController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              "Phone Number ",
                                                          // hintText:
                                                          //     "Add your phone Number",
                                                          icon: Icon(Icons
                                                              .phone_iphone)))),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              child: const Text("Send OTP"),
                                              onPressed: () {
                                                controllers.instancePhoneAuth
                                                    .phoneAuthentication(
                                                        controllers
                                                            .phoneNumberController
                                                            .text
                                                            .trim(),
                                                        context);
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const OTPVerification()),
                                                        (route) => false);
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
                            fontSize: 13,
                            color: Color.fromARGB(255, 19, 19, 216)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DayNightSwitcher(
                      isDarkModeEnabled: isDarkModeEnabled,
                      onStateChanged: onStateChanged,
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
        ),
      ),
    );
  }

  onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }
}

Widget makeInput({label, obsureText = false, controller, onchanged, colors}) {
  var darkModeEnabled = false;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          // ignore: dead_code
          color: colors,
          // color: darkModeEnabled ? Colors.white : Colors.black,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        onChanged: onchanged,
        controller: controller,
        obscureText: obsureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
            // OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            ),
      ),
      const SizedBox(
        height: 30,
      ),
    ],
  );
}
