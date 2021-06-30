import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';

class DateTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController textEditingControl;

  const DateTextField({Key? key, required this.labelText, required this.textEditingControl, required this.hintText})
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
        hintText: hintText,
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
      onTap:  () async{
        DateTime _dateTime = DateTime.now();
        String dateText = "";
        showDatePicker(
          context: context,
          initialDate: _dateTime == null ? DateTime.now() : _dateTime,
          firstDate: DateTime(1980),
          lastDate: DateTime(2022),
        ).then((date) {
          if(date!=null){
            _dateTime = date;
            dateText = "";
            String month = "";
            if(_dateTime.month.toString().length==1){
              month = "0" + _dateTime.month.toString();
            }else{
              month = _dateTime.month.toString();
            }
            String day = "";
            if(_dateTime.day.toString().length==1){
              day = "0" + _dateTime.day.toString();
            }else{
              day = _dateTime.day.toString();
            }
            dateText = dateText + day + "/" + month + "/" + _dateTime.year.toString();
            textEditingControl.text = dateText;
          }else{
            dateText = "";
          }
        });
      },
    );


  }
  }