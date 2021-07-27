import 'package:dietari/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';

class ShowAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  const ShowAlertDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        title,
        // textAlign: TextAlign.center,
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            button_accept,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
