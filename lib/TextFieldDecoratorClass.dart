import 'package:flutter/material.dart';


class TextFieldDecoratorClass{
  TextFieldDecoratorClass();

  InputDecoration decorate(String s) {
    return InputDecoration(

        hintStyle: const TextStyle(fontFamily: "Arial"),
        fillColor: Colors.grey[350],
        filled: true,
        hintText: s,
        labelText: s,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
        contentPadding: const EdgeInsets.all(20));
  }
}