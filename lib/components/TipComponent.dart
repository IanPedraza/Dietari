import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/icons.dart';

class TipComponent extends StatelessWidget {
  final Function() onPressed;
  final Widget? child;
  final String textTip;

  const TipComponent({Key? key, required this.onPressed, this.child, required this.textTip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: colorTextMainButton,
        elevation: 8,
        isExtended: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20,right: 15),
              child: Transform.scale(
                scale: 1.6,
                child: getIcon(AppIcons.light,color: colorLight),
                alignment: Alignment.center,
              ),
            ),
            Expanded(
              child: Text(
                textTip,
                style: TextStyle(
                  color: colorTextBlack,
                  fontWeight: FontWeight.w900,
                  fontSize: 18
                ),
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
    );
  }

}