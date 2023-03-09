
import 'package:doctor_appointment/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Your Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: TextFormField(
                      obscureText: true,
                      controller: newPassword,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                          labelText: "New Password",
                          // hintText:
                          //     "Add your phone Number",
                          icon: Icon(Icons.password)))),
              const SizedBox(
                height: 25,
              ),
              Container(
                  child: TextFormField(
                      obscureText: true,
                      controller: confirmPassword,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                          labelText: "Confirm Password",
                          // hintText:
                          //     "Add your phone Number",
                          icon: Icon(Icons.password)))),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    // Login screen
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  },
                  child: const Text('Set Password'))
            ],
          ),
        ),
      ),
    );
  }
}
