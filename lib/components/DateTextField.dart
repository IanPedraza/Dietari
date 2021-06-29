import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';

class DateTextField extends StatelessWidget {
  final Function() onTap;
  final String labelText;
  final String hintDateText;
  final TextEditingController textEditingControl;

  const DateTextField({Key? key, required this.labelText, required this.textEditingControl, required this.hintDateText, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingControl,
      readOnly: true,
      autofocus: false,
      autocorrect: true,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold
        ),
        hintText: hintDateText,
        hintStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
      onTap: onTap,
    );
  }
}