import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/components/BackButton.dart';

class AppBarComponent extends AppBar {
  AppBarComponent(
      {required String textAppBar,
      required Function() onPressed,
      Color? appBarcolor,
      Color? textColor,
      double? height,
      double? textsize})
      : super(
          elevation: 0,
          toolbarHeight: height != null ? height : 80,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              textAppBar,
              style: TextStyle(
                color: textColor != null ? textColor : primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: textsize != null ? textsize : 30,
              ),
            ),
          ),
          backgroundColor:
              appBarcolor != null ? appBarcolor : colorTextMainButton,
          leading: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: BackButtonDietari(
                onPressed: onPressed,
              ),
            ),
          ),
        );
}
