import 'package:cryptx/Entry_Widgets/entry_text_form_field.dart';
import 'package:flutter/material.dart';

class Login_Screen extends StatelessWidget {
  const Login_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        child: Column(
          children: const <AppTextFormField>[
            AppTextFormField(
                textHolder: "E-mail",
                obscure: false,
                borderRadius: 20,
                icon: Icon(Icons.person)),
            AppTextFormField(
              textHolder: "Password",
              obscure: true,
              borderRadius: 20,
              icon: Icon(Icons.lock_outline),
            ),
          ],
        ),
      ),
    );
  }
}
