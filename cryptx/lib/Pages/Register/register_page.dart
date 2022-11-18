import 'package:cryptx/Entry_Widgets/entry_text_form_field.dart';
import 'package:cryptx/Entry_Widgets/entry_text_form_validator.dart';
import 'package:cryptx/Firebase/db.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Pages/Home/home_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  String? _email;

  String? _password;

  final TextEditingController _emailController = TextEditingController();

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        child: Form(
          key: _registerFormKey,
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
                obscure: true,
                controller: _passwordController,
                borderRadius: 20,
                icon: const Icon(Icons.lock_outline),
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint("asdad");
                  if (validateForm(_registerFormKey, context)) {
                    AppUser newUser = AppUser(null, null, _email!, _password!);
                    registerAppUserDB(newUser);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => const HomePage()),
                      ),
                    );
                  }
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
