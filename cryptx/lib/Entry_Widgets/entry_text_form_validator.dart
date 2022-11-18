import 'package:flutter/material.dart';

bool validateForm(GlobalKey<FormState> key, context) {
  if (key.currentState!.validate()) {
    return true;
  }
  return false;
}

FormFieldValidator passwordValidator(TextEditingController currentPwAuth) {
  return (value) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$');

    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      }
      if (currentPwAuth.text != value) {
        return 'Passwords Does not Match!';
      } else {
        return null;
      }
    }
  };
}

FormFieldValidator pwauthValidator(TextEditingController currentPass) {
  return (value) {
    if (currentPass.text != value) {
      return 'Passwords Does not Match!';
    }
    return null;
  };
}

FormFieldValidator defaultValidator = (value) {
  if (value == null || value.isEmpty) {
    return 'Woops!';
  }
  return null;
};

FormFieldValidator defaultValidatorDropDown(String text) {
  return ((value) {
    if (value == null || value.isEmpty) {
      return 'Please Select your $text';
    }
    return null;
  });
}
