import 'package:flutter/material.dart';

class TodotextField extends StatelessWidget {
  TodotextField({ Key? key, required this.controller, required this.labelText, required this.lines, required this.helpertext, this.color}) : super(key: key);
  TextEditingController controller;
  String labelText;
  String helpertext;
  int lines;
  Color? color = Colors.amber;
  Color colors = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
      child: TextField(
        maxLines: lines,
        style: TextStyle(color: color),
        cursorColor: Colors.black87,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.yellow),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.yellow,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey.shade400,
            ),
          ),
          labelText: labelText,
          helperText: helpertext,
        ),
      ),
    );
  }
}