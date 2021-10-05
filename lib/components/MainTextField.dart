import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/icons.dart';

class MainTextField extends StatefulWidget {
  final Function() onTap;
  final String text;
  final bool isPassword;
  final bool isPasswordTextStatus;
  final TextEditingController textEditingControl;
  final bool isNumber;
  final String? errorText;

  const MainTextField({
    Key? key,
    required this.text,
    required this.isPassword,
    required this.textEditingControl,
    required this.isPasswordTextStatus,
    required this.onTap,
    this.isNumber = false,
    this.errorText,
  }) : super(key: key);

  @override
  _MainTextFieldState createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: primaryColor),
  );

  final _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType:
            widget.isNumber ? TextInputType.number : TextInputType.text,
        controller: widget.textEditingControl,
        autofocus: false,
        autocorrect: true,
        textAlign: TextAlign.left,
        obscureText: widget.isPasswordTextStatus,
        style: TextStyle(
            color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          errorText: widget.errorText,
          labelText: widget.text,
          labelStyle:
              TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          enabledBorder: _border,
          focusedBorder: _border,
          errorBorder: _errorBorder,
          border: _border,
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: widget.isPassword ? widget.onTap : null,
                  child: (widget.isPassword
                      ? (widget.isPasswordTextStatus
                          ? getIcon(AppIcons.visibility_off,
                              color: primaryColor)
                          : getIcon(AppIcons.visibility, color: primaryColor))
                      : null),
                )
              : null,
        ));
  }
}
