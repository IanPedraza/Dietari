import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/icons.dart';
import 'package:sizer/sizer.dart';

class TipComponent extends StatelessWidget {
  final Tip tip;
  final sizeReference = 700.0;

  const TipComponent({
    Key? key,
    required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double getResponsiveText(double size) =>
      size * sizeReference / MediaQuery.of(context).size.longestSide; 

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
            padding: const EdgeInsets.only(left: 10, right: 15),
            child: Transform.scale(
              scale: 1.6,
              child: getIcon(AppIcons.light, color: colorLight),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            child:Text(
              tip.title,
              style: TextStyle(
                  color: colorTextBlack,
                  //fontWeight: FontWeight.w900,
                  fontSize: getResponsiveText(17)),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
    
  }

  
  
}
