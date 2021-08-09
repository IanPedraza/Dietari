import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
//import 'package:dietari/components/BackButton.dart';

class AppBarComponent extends AppBar {
  AppBarComponent({ required String textAppBar, required Function() onPressed})
      :super(
      elevation: 0,
      toolbarHeight: 80,
      title: Text(
          textAppBar,
        style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 30
        ),
      ),
      backgroundColor: colorTextMainButton,
      leading: Container(
        padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
        /*child: BackButtonDietari(
            onPressed: onPressed
        ),*/
      )
  );
}