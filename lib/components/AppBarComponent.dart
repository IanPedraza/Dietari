import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/components/BackButton.dart';

class AppBarComponent extends AppBar {
  AppBarComponent(
      {required String textAppBar,
      required Function() onPressed,
      Color? appBarcolor,
      Color? textColor})
      : super(
          elevation: 0,
          toolbarHeight: 80,
          title: Text(
            textAppBar,
            style: TextStyle(
              color: textColor != null ? textColor : primaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 30,
            ),
          ),
          backgroundColor:
              appBarcolor != null ? appBarcolor : colorTextMainButton,
          leading: Container(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            child: BackButtonDietari(
              onPressed: onPressed,
            ),
          ),
        );
}
