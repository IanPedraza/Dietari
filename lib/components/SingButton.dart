import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingButton extends StatelessWidget {
  final Function() onPressed;
  final Widget? child;
  final String text;
  final String rute;
  final Color textColor;
  const SingButton(
      {Key? key,
      required this.onPressed,
      this.child,
      required this.text,
      required this.rute,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      elevation: 3,
      isExtended: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(this.rute),
            height: 35.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              this.text,
              style: TextStyle(
                  color: this.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
