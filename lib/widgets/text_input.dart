// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget TextInput(
    {required String hint,
    TextInputType keybordType = TextInputType.text,
    double width = double.infinity,
    int maxlines = 1,
    required TextEditingController controller,
    bool isPassword = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 60,
      width: width,
      child: TextField(
        controller: controller,
        // style: TextStyle(color: Colors.white),
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          focusColor: Colors.blue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          labelText: hint,
        ),
        obscureText: isPassword,
        keyboardType: keybordType,
        maxLines: maxlines,
      ),
    ),
  );
}
