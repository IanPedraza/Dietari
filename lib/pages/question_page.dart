import 'package:dietari/components/AnswerOptionCard.dart';
import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/icons.dart';
import 'package:dietari/utils/strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late Test test;
  @override
  Widget build(BuildContext context) {
    _getArguments();
    return Scaffold(
      appBar: AppBarComponent(
        textAppBar: test.title,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 30),
            alignment: Alignment.center,
            child: Text(
              'ID: ${test.id}',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _getArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(context);
      return;
    }
    test = args[test_args];
  }
}
