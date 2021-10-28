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
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColorTestItem,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                textTestItem,
                style: TextStyle(
                  color: colorTextMainButton,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            check
                ? SvgPicture.asset(
                    image_check,
                    width: 35,
                  )
                : Container(),
          ],
        ),
      ),
    );

    // double getResponsiveText(double size) =>
    //     size * sizeReference / MediaQuery.of(context).size.longestSide;

    // return Material(
    //   color: backgroundColorTestItem,
    //   elevation: 8,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   child: InkWell(
    //     onTap: onPressed,
    //     child: Row(
    //       children: [
    //         Expanded(
    //           child: Container(
    //             padding: const EdgeInsets.only(left: 15),
    //             child: Expanded(
    //               child: Text(
    //                 textTestItem,
    //                 style: TextStyle(
    //                   color: colorTextMainButton,
    //                   fontWeight: FontWeight.w900,
    //                   fontSize: getResponsiveText(20),
    //                 ),
    //                 textAlign: TextAlign.left,
    //               ),
    //             ),
    //           ),
    //         ),
    //         Container(
    //           padding: const EdgeInsets.only(left: 20, right: 25),
    //           child: check ? SvgPicture.asset(image_check, width: 40) : null,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
