import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';

String DateText = "";
String Date = "";
int aux=0;

class DateTextField extends StatefulWidget{
  final String LabelText;
  final String HintText;
  final TextEditingController TextEditingControl;
  const DateTextField({Key? key, required this.LabelText, required this.TextEditingControl, required this.HintText})
      : super(key: key);
  @override
  _DateTextField createState() => _DateTextField();
}

class _DateTextField extends State<DateTextField> {
  DateTime ChooseDay = DateTime.now();
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: widget.TextEditingControl,
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
          labelText: widget.LabelText,
          labelStyle: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold
          ),
          hintText: aux==0
            ? widget.HintText : DateText,
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
      onTap: _selectDate,
    );

  }

  Future _selectDate() async {
    showDatePicker(
        context: context,
        initialDate: _dateTime == null ? DateTime.now() : _dateTime,
        firstDate: DateTime(1980),
        lastDate: DateTime(2022),
    ).then((date) {
      setState(() {
        if(date!=null){
          _dateTime = date;
          DateText = "";
          String Month = "";
          if(_dateTime.month.toString().length==1){
            Month = "0" + _dateTime.month.toString();
          }else{
            Month = _dateTime.month.toString();
          }
          String Day = "";
          if(_dateTime.day.toString().length==1){
            Day = "0" + _dateTime.day.toString();
          }else{
            Day = _dateTime.day.toString();
          }
          DateText = DateText + Day + "/" + Month + "/" + _dateTime.year.toString();
          widget.TextEditingControl.text = DateText;
          aux =1;
        }else{
          DateText = "";
        }
      });
    });
    }
}