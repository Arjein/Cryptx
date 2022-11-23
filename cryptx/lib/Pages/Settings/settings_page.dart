import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Firebase/db.dart';
import 'package:cryptx/Pages/Login/login_page.dart';
import 'package:cryptx/Storage/user_secure_storage.dart';
import 'package:flutter/material.dart';

class Settings_Screen extends StatelessWidget {
  const Settings_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return tempSettingsTile();
        },
      ),
    );
  }
}

class tempSettingsTile extends StatelessWidget {
  const tempSettingsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      margin: EdgeInsets.all(5),
      child: TextButton(
          onPressed: () async {
            // Navigate back to the login
            updateUseronLogOut(CurrentUser.firebaseUser!, CurrentUser.user!);
            await Future.delayed(const Duration(seconds: 2));
            if (await UserSecureStorage.deleteStorage()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            }
          },
          child: Text(
            "Log Out",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.red),
          )),
    );
  }
}
