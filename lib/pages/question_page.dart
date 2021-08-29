import 'package:dietari/components/AnswerOptionCard.dart';
import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        textAppBar: "3/10",
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
              "¿Pregunta del Cuestionario?",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 30),
            child: AnswerOptionCard(
              onPressed: () {},
              textAnswer: "Respuesta 1",
              choosen: false,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 30),
            child: AnswerOptionCard(
              onPressed: () {},
              textAnswer: "Respuesta 2",
              choosen: false,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 30),
            child: AnswerOptionCard(
              onPressed: () {},
              textAnswer: "Respuesta 3",
              choosen: false,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 30),
            child: AnswerOptionCard(
              onPressed: () {},
              textAnswer: "Respuesta 4",
              choosen: false,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 30),
            child: AnswerOptionCard(
              onPressed: () {},
              textAnswer: "Respuesta 5",
              choosen: true,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 30),
            child: MainButton(
              onPressed: () {},
              text: button_next,
            ),
          ),
        ],
      ),
    );
  }
}
