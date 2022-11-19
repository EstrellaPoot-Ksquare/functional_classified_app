import 'package:flutter/material.dart';

class Validators {
  // static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static bool isValidForm(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  static String? validateStringNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required field';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value ?? '')
        ? null
        : 'Email is not a valid email address';
  }
}
