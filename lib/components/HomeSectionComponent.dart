import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';

class HomeSectionComponent extends StatelessWidget {
  final Function() onPressed;
  final String textHomeSectionComponent;
  final Widget content;
  final sizeReference = 700.0;

  const HomeSectionComponent({
    Key? key,
    required this.onPressed,
    required this.textHomeSectionComponent,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getResponsiveText(double size) =>
        size * sizeReference / MediaQuery.of(context).size.longestSide;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 30,
            bottom: 10,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Text(
                  textHomeSectionComponent,
                  style: TextStyle(
                      color: colorBlack,
                      fontWeight: FontWeight.w900,
                      fontSize: getResponsiveText(27)),
                  textAlign: TextAlign.left,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    onPressed();
                  },
                  child: Text(
                    "Ver más",
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: getResponsiveText(18)),
                  ),
                )
              ],
            ),
          ),
        ),
        content
      ],
    );
  }
}
