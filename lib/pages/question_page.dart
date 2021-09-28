import 'package:dietari/components/AnswerOptionCard.dart';
import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/ShowAlertDialog.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/domain/UserOption.dart';
import 'package:dietari/data/domain/UserQuestion.dart';
import 'package:dietari/data/domain/UserTest.dart';
import 'package:dietari/data/framework/firebase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/framework/firebase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/AddUserTestUseCase.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late UserDataSource _userDataSource = FirebaseUserDataSouce();

  late UserRepository _userRepository =
      UserRepository(userDataSource: _userDataSource);

  late AddUserTestUseCase _addUserTestUseCase =
      AddUserTestUseCase(userRepository: _userRepository);

  late AuthDataSource _authDataSource = FirebaseAuthDataSource();

  late AuthRepository _authRepository =
      AuthRepository(authDataSource: _authDataSource);

  late GetUserIdUseCase _getUserIdUseCase =
      GetUserIdUseCase(authRepository: _authRepository);

  late Test test;
  late UserTest _userTest;
  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);
  List<bool> choose = List.generate(10, (index) => false);
  List<int> _options = List.generate(10, (index) => -1);

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
    _createUserTest();
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
              _userTest.description,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _userTest.questions.length,
                (index) => buildDot(index),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.55,
              minHeight: 100,
            ),
            child: PageView.builder(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: _userTest.questions.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, top: 0, right: 15, bottom: 30),
                      alignment: Alignment.center,
                      child: Text(
                        _userTest.questions[index].question,
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
                        itemCount: _userTest.questions[index].options.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int indx) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 15, top: 10, right: 15, bottom: 10),
                            child: AnswerOptionCard(
                              onPressed: () {
                                _setChoosen(indx);
                              },
                              textAnswer:
                                  _userTest.questions[index].options[indx].name,
                              choosen: choose[indx],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
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

  void _createUserTest() {
    _userTest = new UserTest(
      title: test.title,
      description: test.description,
      id: test.id,
      isComplete: false,
      questions: [],
    );
    for (int i = 0; i < test.questions.length; i++) {
      UserQuestion _userQuestion =
          new UserQuestion(question: test.questions[i].question, options: []);
      for (int j = 0; j < test.questions[i].options.length; j++) {
        UserOption _userOption = new UserOption(
          name: test.questions[i].options[j].name,
          value: test.questions[i].options[j].value,
          isSelected: false,
        );
        _userQuestion.options.add(_userOption);
      }
      _userTest.questions.add(_userQuestion);
    }
  }

  void _nextPage() {
    if (choose.contains(true)) {
      if (currentIndex == _userTest.questions.length - 1) {
        _saveAnswers();
        _userTest.isComplete = true;
        String? id = _getUserIdUseCase.invoke();
        if (id != null) {
          _addUserTest(id, _userTest).then(
            (isDone) => {
              if (isDone)
                {Navigator.pushNamed(context, finished_test_route)}
              else
                {
                  _showAlertDialog(context, alert_title_error,
                      alert_content_not_aggregated_responses),
                  Navigator.of(context).pop()
                }
            },
          );
        }
      }
      choose = List.generate(10, (i) => false);
      _controller.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.bounceIn,
      );
    } else {
      _showAlertDialog(context, alert_title, alert_content_answer_question);
    }
  }

  void _saveAnswers() {
    for (int i = 0; i < _userTest.questions.length; i++) {
      _userTest.questions[i].options[_options[i]].isSelected = true;
      print(_options[i]);
    }
  }

  void _setChoosen(int index) {
    choose = List.generate(10, (i) => false);
    setState(() {
      choose[index] = !choose[index];
      _options[currentIndex] = index;
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

  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowAlertDialog(
          title: title,
          content: content,
        );
      },
    );
  }

  Future<bool> _addUserTest(String userId, UserTest userTest) async {
    bool addUser = await _addUserTestUseCase.invoke(userId, userTest);
    return addUser;
  }
}
