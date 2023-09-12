import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lab3/login.dart';
import 'package:lab3/main.dart';

class MyView extends State<MyHome> {
  double logoOpacity = 0;
  double circularOpacit = 0;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        logoOpacity = 1;
        circularOpacit=1;
      });
    });
    super.initState();
    Timer(
      const Duration(seconds: 7),
          () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            var tween = Tween(begin: const Offset(1.0,0.0), end: Offset.zero);
            return SlideTransition(
              position: animation.drive(tween),
              child: const login(),
            );
          },
          transitionDuration: const Duration(seconds: 1),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Image.asset(
            "assets/image.jpg",
            fit: BoxFit.cover,
          ),
        ),
        AnimatedOpacity(
          opacity: logoOpacity,
          duration: const Duration(seconds: 2),
          child: Center(
              child: Image.asset(
                "assets/logo.png",
                width: 170,
                height: 170,
              )),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 100),
          alignment: AlignmentDirectional.bottomCenter,
          child: AnimatedOpacity(
            opacity: circularOpacit,
            duration: const Duration(seconds: 4),
            child: const CircularProgressIndicator(
              value: null,
              strokeAlign: 1,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
