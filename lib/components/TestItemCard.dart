import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestItemCard extends StatelessWidget {
  final Function() onPressed;
  final Widget? child;
  final String textTestItem;
  final bool check;

  const TestItemCard({Key? key, required this.onPressed, this.child, required this.textTestItem,required this.check})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColorTestItem,
      elevation: 8,
      isExtended: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                textTestItem,
                style: TextStyle(
                    color: colorTextMainButton,
                    //fontWeight: FontWeight.w900,
                    fontSize: 22
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.only(left: 20,right: 25),
            child: check ?
              SvgPicture.asset('assets/check.svg',width: 40)
                :null
            ,
          ),
        ],
      ),
    );
  }

}