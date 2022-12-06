import 'package:cryptx/Constants/device_options.dart';
import 'package:cryptx/Entry_Widgets/entry_text_form_field.dart';
import 'package:cryptx/Entry_Widgets/entry_text_form_validator.dart';
import 'package:cryptx/Firebase/auth.dart';
import 'package:cryptx/Firebase/db.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Pages/Home/home_page.dart';
import 'package:cryptx/Pages/Login/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  String? _email;
  String? _username;
  String? _password;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _emailController.addListener(() {
      _email = _emailController.text;
    });
    _passwordController.addListener(() {
      _password = _passwordController.text;
    });
    _usernameController.addListener(() {
      _username = _usernameController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: [
                AppTextFormField(
                  textHolder: "Username",
                  obscure: false,
                  controller: _usernameController,
                  borderRadius: 20,
                  icon: const Icon(Icons.face),
                ),
                AppTextFormField(
                    textHolder: "E-mail",
                    obscure: false,
                    controller: _emailController,
                    borderRadius: 20,
                    icon: const Icon(Icons.person)),
                AppTextFormField(
                  textHolder: "Password",
                  obscure: true,
                  controller: _passwordController,
                  borderRadius: 20,
                  icon: const Icon(Icons.lock_outline),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(
                          UserDevice.getDeviceHeight(context) * 0.05),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () async {
                      if (validateForm(_registerFormKey, context)) {
                        AppUser newUser = AppUser(_username!, _email!,
                            _password!, <String, dynamic>{"USDT": 1000});
                        if (await registerUser(newUser)) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => Login_Screen()),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
