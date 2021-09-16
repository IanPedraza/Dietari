import 'package:dietari/components/AnswerOptionCard.dart';
import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late Test test;
  
  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);
  bool choosen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              test.description,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.65,
              minHeight: 100,
            ),
            child: PageView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: test.questions.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          test.questions.length,
                          (index) => buildDot(index),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, top: 0, right: 15, bottom: 30),
                      alignment: Alignment.center,
                      child: Text(
                        test.questions[index].question,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: test.questions[index].options.length,
                        itemBuilder: (context, int indx) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 15, top: 10, right: 15, bottom: 10),
                            child: AnswerOptionCard(
                              onPressed: _setChoosen,
                              textAnswer:
                                  test.questions[index].options[indx].name,
                              choosen: choosen,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 15),
            child: MainButton(
              onPressed: _nextPage,
              text: currentIndex == test.questions.length - 1
                  ? button_finish
                  : button_next,
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

  void _nextPage() {
    _controller.nextPage(
        duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  void _setChoosen() {
    setState(() {
      choosen = !choosen;
    });
  }

  Container buildDot(int index) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(right: 5, bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor, width: 1),
        color: currentIndex == index ? primaryColor : Colors.transparent,
      ),
    );
  }
}
