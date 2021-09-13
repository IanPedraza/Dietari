import 'package:dietari/components/AnswerOptionCard.dart';
import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/data/datasources/TestsDataSource.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/framework/FireBase/FirebaseTestsDataSource.dart';
import 'package:dietari/data/repositories/TestsRepository.dart';
import 'package:dietari/data/usecases/AddTestUseCase.dart';
import 'package:dietari/data/usecases/GetTestUseCase.dart';
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
  late TestsDataSource testsDataSource = FirebaseTestsDataSource();

  late TestsRepository testsRepository =
      new TestsRepository(testsDataSource: testsDataSource);

  late AddTestUseCase addTestUseCase =
      new AddTestUseCase(testsRepository: testsRepository);

  late GetTestUseCase getTestUseCase =
      GetTestUseCase(testsRepository: testsRepository);

  late Stream<Test?> _testStream;
  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);
  bool choosen = false;

  @override
  void initState() {
    _testStream = _getTest('C7yzmYSyZZsJ4TLUGzXZ').asStream();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        textAppBar: 'MNA Básico',
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: StreamBuilder<Test?>(
        stream: _testStream,
        builder: (context, AsyncSnapshot<Test?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                ),
                width: 175,
                height: 175,
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Transform.scale(
                scale: 7,
                alignment: Alignment.center,
                child: getIcon(
                  AppIcons.error,
                  color: primaryColor,
                ),
              ),
            );
          }
          Test? test = snapshot.data;
          return ListView(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 30),
                alignment: Alignment.center,
                child: Text(
                  test!.description,
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
                padding:
                    EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 15),
                child: MainButton(
                  onPressed: _nextPage,
                  text: currentIndex == test.questions.length - 1
                      ? button_finish
                      : button_next,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _nextPage() {
    /*if (currentIndex == test.questions.length - 1) {
        Navigator.pushNamed(context, finished_test_route);
    }*/
    _controller.nextPage(
        duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  void _setChoosen() {
    setState(() {
      choosen = !choosen;
    });
  }

  Future<Test?> _getTest(String id) async {
    Test? test = await getTestUseCase.invoke(id);
    return test;
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

  Future firebaseiniciation() async {
    FirebaseApp initialization = await Firebase.initializeApp();
    return initialization;
  }
}
