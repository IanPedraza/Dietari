import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/icons.dart';

class AnswerOptionCard extends StatelessWidget {
  final Function() onPressed;
  final Widget? child;
  final String textAnswer;
  final bool choosen;

  const AnswerOptionCard({
    Key? key,
    required this.onPressed,
    this.child,
    required this.textAnswer,
    required this.choosen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: colorTextMainButton,
      elevation: 8,
      isExtended: true,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: colorAnswerOptionCard),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                textAnswer,
                style: TextStyle(color: primaryColor, fontSize: 22),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.only(right: 25),
            child: Transform.scale(
              scale: 1.6,
              child: choosen
                  ? getIcon(AppIcons.check, color: colorAnswerOptionCard)
                  : getIcon(AppIcons.uncheck, color: colorAnswerOptionCard),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
