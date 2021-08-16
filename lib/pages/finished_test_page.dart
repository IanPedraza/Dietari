import 'package:dietari/utils/colors.dart';
import 'package:flutter/material.dart';

class FinishedTestPage extends StatefulWidget {
  FinishedTestPage({Key? key}) : super(key: key);

  @override
  _FinishedTestPageState createState() => _FinishedTestPageState();
}

class _FinishedTestPageState extends State<FinishedTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorFinishedTestPage,
      body: ListView(
        children: [
          Icon(
            Icons.query_builder,
          )
        ],
      ),
    );
  }
}
