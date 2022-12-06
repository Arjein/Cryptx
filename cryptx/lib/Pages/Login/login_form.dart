import 'package:cryptx/Constants/Constants.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Entry_Widgets/entry_text_form_field.dart';
import 'package:cryptx/Entry_Widgets/entry_text_form_validator.dart';
import 'package:cryptx/Firebase/auth.dart';
import 'package:cryptx/Firebase/db.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Pages/Home/home_page.dart';
import 'package:cryptx/Storage/user_secure_storage.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.loginFormKey,
  }) : super(key: key);

  final GlobalKey<FormState> loginFormKey;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String? _email;
  late String? _password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    init();

    super.initState();
  }

  Future init() async {
    _email = await UserSecureStorage.getEmail() ?? '';
    _password = await UserSecureStorage.getPassword() ?? '';

    setState(() {
      _emailController.text = _email!;
      _passwordController.text = _password!;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.loginFormKey,
      child: Column(
        children: [
          AppTextFormField(
              textHolder: "E-mail",
              obscure: false,
              controller: _emailController,
              borderRadius: 20,
              icon: const Icon(Icons.person)),
          AppTextFormField(
            textHolder: "Password",
            controller: _passwordController,
            obscure: true,
            borderRadius: 20,
            icon: const Icon(Icons.lock_outline),
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              onPressed: () async {
                if (validateForm(widget.loginFormKey, context)) {
                  if (await authUser(
                      _emailController.text, _passwordController.text)) {
                    // TODO
                    debugPrint("User Authenticated");
                    AppUser? user = await readUserfromDB(_emailController.text);
                    if (user != null &&
                        await UserSecureStorage.setUser(
                            user, _passwordController.text)) {
                      CurrentUser.user = await UserSecureStorage.getUser();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false);
                    }
                  }
                }
              },
              child: const Text("Login"))
        ],
      ),
    );
  }
}
