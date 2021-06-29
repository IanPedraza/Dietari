import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';

bool visible=true;
int aux = 0;

class MainTextField extends StatefulWidget{
  final String text;
  final bool isPassword;
  final TextEditingController TextEditingControl;
  const MainTextField({Key? key, required this.text,required this.isPassword, required this.TextEditingControl})
      : super(key: key);
  @override
  _MainTextField createState() => _MainTextField();
}

class _MainTextField extends State<MainTextField> {
  void _showPassword(){
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: widget.TextEditingControl,
      autofocus: false,
      autocorrect: true,
      textAlign: TextAlign.left,
      obscureText: widget.isPassword
        ? visible : false,
      //obscureText: visible,
      style: TextStyle(
          color: primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),

      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: TextStyle(
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
        suffixIcon: InkWell(
          onTap: widget.isPassword
              ? _showPassword : null,
          child: Icon(
            widget.isPassword
                ?  (visible
                ?  Icons.visibility_off : Icons.visibility): null,
            color: primaryColor,
          ),
        ),
      ),

    );

  }
}