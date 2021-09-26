// ignore_for_file: file_names, prefer_const_constructors

import 'package:evrka_case/customWidgets/greenButton.dart';
import 'package:evrka_case/views/Operations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> loginChecker() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: username.text,
      password: password.text,
    )
        .then((user) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Operations(),
        ),
      );
    }).whenComplete(() => print("Logged in"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color(0xFFE1E1E1),
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Logo.png"),
              SizedBox(
                height: 50,
              ),
              Text(
                "Please enter your username and password.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: username,
                decoration: InputDecoration(hintText: "Username"),
              ),
              TextField(
                controller: password,
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(
                height: 50,
              ),
              GreenButton("LOGIN", loginChecker)
            ],
          ),
        ),
      ),
    );
  }
}
