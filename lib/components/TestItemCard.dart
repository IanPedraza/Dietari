import 'package:dietari/utils/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestItemCard extends StatelessWidget {
  final Function() onPressed;
  final String textTestItem;
  final bool check;
  final sizeReference = 700.0;

  const TestItemCard(
      {Key? key,
      required this.onPressed,
      required this.textTestItem,
      required this.check})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    double getResponsiveText(double size) =>
      size * sizeReference / MediaQuery.of(context).size.longestSide; 

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColorTestItem,
      elevation: 8,
      isExtended: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Expanded(
                child: Text(
                  textTestItem,
                  style: TextStyle(
                      color: colorTextMainButton,
                      fontWeight: FontWeight.w900,
                      fontSize: getResponsiveText(20)),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 25),
            child: check ? SvgPicture.asset(image_check, width: 40) : null,
          ),
        ],
      ),
    );
  }
}
