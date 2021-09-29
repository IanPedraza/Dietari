import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/icons.dart';

class TipComponent extends StatelessWidget {
  final Tip tip;

  const TipComponent({
    Key? key,
    required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final args = {tip_args: tip};
        Navigator.pushNamed(context, tip_route, arguments: args);
      },
      backgroundColor: colorTextMainButton,
      elevation: 8,
      isExtended: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Transform.scale(
              scale: 1.6,
              child: getIcon(AppIcons.light, color: colorLight),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            child: Text(
              tip.title,
              style: TextStyle(
                  color: colorTextBlack,
                  //fontWeight: FontWeight.w900,
                  fontSize: 18),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}
