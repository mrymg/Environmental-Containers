// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

Widget GreenButton(String text, Function() target, double width) {
  return GestureDetector(
    onTap: target,
    child: Container(
        width: width,
        height: 43,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF72C875),
              spreadRadius: 1.5,
              blurRadius: 8,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: Color(0xFFFBFCFF),
              fontSize: 20,
              fontFamily: "Open Sans",
              fontWeight: FontWeight.bold),
        ))),
  );
}
