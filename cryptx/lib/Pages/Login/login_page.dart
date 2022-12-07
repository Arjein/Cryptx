import 'package:cryptx/Constants/Constants.dart';
import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/device_options.dart';
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
            UserDevice.addVerticalSpace(context, 12),
            Image.asset("assets/images/logo.png"),
            UserDevice.addVerticalSpace(context, 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: LoginForm(loginFormKey: _loginFormKey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a Member? "),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => RegisterPage()),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign-up!",
                    style: TextStyle(color: AppColors.lightBlue),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
