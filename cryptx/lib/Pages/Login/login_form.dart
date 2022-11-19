import 'package:cryptx/Entry_Widgets/entry_text_form_field.dart';
import 'package:cryptx/Entry_Widgets/entry_text_form_validator.dart';
import 'package:cryptx/Firebase/auth.dart';
import 'package:cryptx/Firebase/db.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Pages/Home/home_page.dart';
import 'package:cryptx/Storage/user_secure_storage.dart';
import 'package:flutter/material.dart';

class login_form extends StatefulWidget {
  const login_form({
    Key? key,
    required this.loginFormKey,
  }) : super(key: key);

  final GlobalKey<FormState> loginFormKey;

  @override
  State<login_form> createState() => _login_formState();
}

class _login_formState extends State<login_form> {
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
          ElevatedButton(
              onPressed: () async {
                if (validateForm(widget.loginFormKey, context)) {
                  if (await Auth_User(
                      _emailController.text, _passwordController.text)) {
                    // TODO
                    debugPrint("User Authenticated");
                    AppUser? user = await readUserfromDB(_emailController.text);

                    if (user != null &&
                        await UserSecureStorage.setUser(
                            user, _passwordController.text)) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    appUser: user,
                                  )),
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
