String ValidateEmail(String txt) {
  if (txt.isEmpty) {
    return "Email can not null ";
  }
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  if (!emailRegExp.hasMatch(txt)) {
    return "Invalid email format";
  }
  return "";
}

String ValidatePass(String txt) {
  if (txt.isEmpty) {
    return "Password can not null ";
  }
  if (txt.length < 6) {
    return "Password must be greater than 6 characters";
  }
  return "";
}

String ValidateRepass(String txt, String pass) {
  if (txt.isEmpty) {
    return "Confirm password cannot be empty";
  }
  if (txt != pass) {
    return "Password and Confirm Password do not match";
  }
  return "";
}

String ValidateEmailLogin(String txt) {
  if (txt.isEmpty) {
    return "Email can not null ";
  }
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  if (!emailRegExp.hasMatch(txt)) {
    return "Invalid email format";
  }
  return "";
}

String ValidatePassLogin(String txt) {
  if (txt.isEmpty) {
    return "Password can not null ";
  }
  if (txt.length < 6) {
    return "Password must be greater than 6 characters";
  }
  return "";
}
