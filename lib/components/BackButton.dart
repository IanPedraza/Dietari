import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/icons.dart';

class BackButtonDietari extends StatelessWidget {
  final Function() onPressed;

  const BackButtonDietari({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: FloatingActionButton(
        child: Container(
          child: Transform.scale(
            scale: 1.5,
            child: getIcon(AppIcons.arrow_back,color: primaryColor),
            alignment: Alignment.center,
          ),
        ),
        onPressed: onPressed,
        backgroundColor: colorTextMainButton,
        elevation: 7,
      ),
    );
  }

}