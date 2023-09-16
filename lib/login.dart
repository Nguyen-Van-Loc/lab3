import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lab3/homeSceen.dart';
import 'package:lab3/signUp.dart';
import 'package:lab3/validatefrom/validate.dart';

// ignore: camel_case_types
class login extends StatefulWidget {
  const login({super.key});

  @override
  ViewLogin createState() => ViewLogin();
}

class ViewLogin extends State<login> {
  String email="", pass="";String emailErr="", passErr="";
  final _emailControler = TextEditingController();
  final _passControler = TextEditingController();
  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }
  void validateEmail(){
    setState(() {
      emailErr =ValidateEmailLogin(_emailControler.text);
    });
  }
  void validatePass(){
    setState(() {
      passErr =ValidatePassLogin(_passControler.text);
    });
  }
  void onLogin(){
    validateEmail();
    if(emailErr.isEmpty){
      validatePass();
      if(passErr.isEmpty){
        EasyLoading.show(status: "loading..");
        _signIn();
      }
    }
  }
  void _signIn() async {
    // EasyLoading.show(status: "loading...");
    String email = _emailControler.text;
    String password = _passControler.text;
    try {
      final UserCredential() = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.toString().trim(),
              password: password.toString().trim());
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondary) =>
              FadeTransition(opacity: animation,child: Home(),)
            ));
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError("Email or password is incorrect");
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
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            // Điều chỉnh mức độ mờ
            child: Container(
              color: const Color(0xff111110)
                  .withOpacity(0.5), // Đặt màu nền trong suốt
            ),
          ),
           Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 170, bottom: 50),
                child: const Text(
                  "Login",
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
                        decoration: InputDecoration(
                            errorText: emailErr.isNotEmpty?emailErr:null,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Email Address",
                            contentPadding: const EdgeInsets.all(18),
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.red))),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
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
                                decoration: InputDecoration(
                                    errorText: passErr.isNotEmpty?passErr:null,
                                    suffixIcon: GestureDetector(
                                      onTap: _toggleObscured,
                                      child: _obscured
                                          ? const Icon(
                                              CupertinoIcons.eye_slash_fill)
                                          : const Icon(CupertinoIcons.eye),
                                    ),
                                    errorStyle: const TextStyle(
                                        color: Color(0xffff0000)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Password",
                                    contentPadding: const EdgeInsets.all(18),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.red))),
                              )),
                        ]),
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot password?",
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 14,
                              color: Color(0xFFA09F99)))),
                ),
              ]),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                      onLogin();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0acf83)),
                  child: const Text("Login"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, top: 30, right: 30),
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
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
            ]),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don’t have an account?",
                  style: TextStyle(fontSize: 16, color: Color(0xFFD8D8DD)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: const Text("Signup",
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
    _passControler.dispose();
    _emailControler.dispose();
    super.dispose();
  }
}
