import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String? ValidateEmail(String? txt) {
  if (txt == null || txt.isEmpty) {
    return "Email can not null ";
  }
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  if (!emailRegExp.hasMatch(txt)) {
    return "Invalid email format";
  }
  return null;
}

String? ValidatePass(String? txt) {
  if (txt == null || txt.isEmpty) {
    return "Password can not null ";
  }
  if (txt.length < 6) {
    return "Password must be greater than 6 characters";
  }
  return null;
}

String? ValidateRepass(String? txt, String? pass) {
  if (txt == null || txt.isEmpty) {
    return "Confirm password cannot be empty";
  }
  if (txt != pass) {
    return "Password and Confirm Password do not match";
  }
  return null;
}

String? ValidateEmailLogin(String? txt) {
  if (txt == null || txt.isEmpty) {
    return "Email can not null ";
  }
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  if (!emailRegExp.hasMatch(txt)) {
    return "Invalid email format";
  }
  return null;
}

String? ValidatePassLogin(String? txt) {
  if (txt == null || txt.isEmpty) {
    return "Password can not null ";
  }
  if (txt.length < 6) {
    return "Password must be greater than 6 characters";
  }
  return null;
}
