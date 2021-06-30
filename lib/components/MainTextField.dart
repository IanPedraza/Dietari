import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/icons.dart';

class MainTextField extends StatelessWidget {
  final Function() onTap;
  final String text;
  final bool isPassword;
  final bool isPasswordTextStatus;
  final TextEditingController textEditingControl;

  const MainTextField(
      {Key? key,
      required this.text,
      required this.isPassword,
      required this.textEditingControl,
      required this.isPasswordTextStatus,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingControl,
      autofocus: false,
      autocorrect: true,
      textAlign: TextAlign.left,
      obscureText: isPasswordTextStatus,
      style: TextStyle(
          color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor),
        ),
        suffixIcon: InkWell(
          onTap: isPassword ? onTap : null,
          child: (isPassword
              ? (isPasswordTextStatus
                  ? getIcon(AppIcons.visibility_off, color: primaryColor)
                  : getIcon(AppIcons.visibility, color: primaryColor))
              : null),
        ),
      ),
    );
  }
}
