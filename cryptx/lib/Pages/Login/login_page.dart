import 'package:cryptx/Pages/Login/login_form.dart';
import 'package:cryptx/Pages/Register/register_page.dart';
import 'package:flutter/material.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({super.key});
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SafeArea(
        child: ListView(
          children: [
            LoginForm(loginFormKey: _loginFormKey),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => RegisterPage()),
                        ),
                      );
                    },
                    child: const Text("Sign-up!")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
