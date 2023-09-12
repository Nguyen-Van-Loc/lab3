import 'package:flutter/material.dart';
import 'package:lab3/login.dart';

class Home extends StatefulWidget {
  ViewHome createState() => ViewHome();
}

class ViewHome extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Wellcome",
              style: TextStyle(fontSize: 22, fontFamily: "Lato"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context,animation,secondary) =>
                              SlideTransition(position: Tween<Offset>(
                                begin: const Offset(-1,0),
                                end: Offset.zero,
                              ).animate(animation),
                                child: const login(),)));
                },
                child: Text("SignOut"))
          ],
        ),
      ),
    );
  }
}
