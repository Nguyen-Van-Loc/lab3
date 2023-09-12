import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab3/validatefrom/validate.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  ViewSignUp createState() => ViewSignUp();
}

class ViewSignUp extends State<SignUp> {
  String? email, pass, repass;
  final _emailControler = TextEditingController();
  final _passControler = TextEditingController();
  final _repassControler = TextEditingController();
  bool _obscured = true;
  final checkValidate = GlobalKey<FormState>();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }
  void _signUp() async {
    String email = _emailControler.text;
    String password = _passControler.text;
    try {
      final UserCredential() =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.showSuccess("Great Success!");
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'email-already-in-use') {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            loopAnimation: true,
            text: "Account already exists");
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/image.jpg",
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
            child: Container(
              color: const Color(0xff111110).withOpacity(0.5),
            ),
          ),
          Form(
            key: checkValidate,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100, bottom: 50),
                  child: const Text(
                    "Signup",
                    style: TextStyle(
                        fontSize: 36,
                        color: Color(0xffffffff),
                        fontFamily: "Lato"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        child: const Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: "Lato"),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                            controller: _emailControler,
                            validator: (text) {
                              return ValidateEmail(text);
                            },
                            onChanged: (txt) => txt = email!,
                            decoration: InputDecoration(
                                errorStyle:
                                    const TextStyle(color: Color(0xffff0000)),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Email Address",
                                contentPadding: const EdgeInsets.all(18),
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                )))),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: const Text(
                                  "Password",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: "Lato"),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: TextFormField(
                                  controller: _passControler,
                                  obscureText: _obscured,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (text) {
                                    return ValidatePass(text);
                                  },
                                  onChanged: (txt) => txt = pass!,
                                  decoration: InputDecoration(
                                      errorStyle: const TextStyle(
                                          color: Color(0xffff0000)),
                                      suffixIcon: GestureDetector(
                                        onTap: _toggleObscured,
                                        child: _obscured
                                            ? const Icon(
                                                CupertinoIcons.eye_slash_fill)
                                            : const Icon(CupertinoIcons.eye),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Password",
                                      contentPadding: const EdgeInsets.all(18),
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.red))),
                                )),
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: const Text(
                                  "Confirm password",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: "Lato"),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: TextFormField(
                                  controller: _repassControler,
                                  obscureText: _obscured,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (text) {
                                    return ValidateRepass(
                                        text, _passControler.text);
                                  },
                                  onChanged: (txt) => txt = repass!,
                                  decoration: InputDecoration(
                                      errorStyle: const TextStyle(
                                          color: Color(0xffff0000)),
                                      suffixIcon: GestureDetector(
                                        onTap: _toggleObscured,
                                        child: _obscured
                                            ? const Icon(
                                                CupertinoIcons.eye_slash_fill)
                                            : const Icon(CupertinoIcons.eye),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Confirm password",
                                      contentPadding: const EdgeInsets.all(18),
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.red))),
                                )),
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (checkValidate.currentState!.validate()) {
                            EasyLoading.show(status: "loading...");
                            _signUp();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0acf83)),
                        child: const Text("Login"),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 30, top: 10, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            height: 1,
                            color: Colors.white,
                          ),
                          const Text(
                            "Or login with",
                            style: TextStyle(color: Color(0xFFD8D8DD)),
                          ),
                          Container(
                            width: 100,
                            height: 1,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  backgroundColor: const Color(0xff595858)),
                              child: Image.asset(
                                "assets/google-logo.png",
                                width: 20,
                                height: 25,
                              )),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  backgroundColor: const Color(0xff595858)),
                              child: Image.asset(
                                "assets/facebook-xxl.png",
                                width: 20,
                                height: 25,
                              )),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  backgroundColor: const Color(0xff595858)),
                              child: Image.asset(
                                "assets/apple-xxl.png",
                                width: 20,
                                height: 25,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account! ",
                  style: TextStyle(fontSize: 16, color: Color(0xFFD8D8DD)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Login",
                        style: TextStyle(
                            color: Color(0xff0acf83),
                            fontWeight: FontWeight.bold,
                            fontSize: 16))),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ])
        ],
      ),
    );
  }

  @override
  void dispose() {
    _repassControler.dispose();
    _passControler.dispose();
    _emailControler.dispose();
    super.dispose();
  }
}
