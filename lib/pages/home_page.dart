import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietari/components/HomeSectionComponent.dart';
import 'package:dietari/components/TestItemCard.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/datasources/TestsDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/domain/UserTest.dart';
import 'package:dietari/data/framework/FireBase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/framework/FireBase/FirebaseConstants.dart';
import 'package:dietari/data/framework/FireBase/FirebaseTestsDataSource.dart';
import 'package:dietari/data/framework/FireBase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/repositories/TestsRepository.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/GetTestsUseCase.dart';
import 'package:dietari/data/usecases/GetUserTestUseCase.dart';
import 'package:dietari/data/usecases/SignOutUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietari/components/AppFloatingActionButton.dart';
import 'package:dietari/utils/icons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthDataSource _authDataSource = FirebaseAuthDataSource();

  late AuthRepository _authRepository =
      AuthRepository(authDataSource: _authDataSource);

  late SignOutUseCase _signOutUseCase =
      SignOutUseCase(authRepository: _authRepository);

  late TestsDataSource _testsDataSource = FirebaseTestsDataSource();

  late TestsRepository _testsRepository =
      TestsRepository(testsDataSource: _testsDataSource);

  late GetTestsUseCase _getTestsUseCase =
      GetTestsUseCase(testsRepository: _testsRepository);

  late UserDataSource _userDataSource = FirebaseUserDataSouce();

  late UserRepository _userRepository =
      UserRepository(userDataSource: _userDataSource);

  late GetUserTestUseCase _getUserTestUseCase =
      GetUserTestUseCase(userRepository: _userRepository);

  late User newUser;
  int currentIndex = 0;
  late PageController _controller;
  late Stream<List<Test>> _testStream;

  @override
  void initState() {
    /*_testStream =
        FirebaseFirestore.instance.collection(TESTS_COLLECTION).snapshots();*/
    _testStream = _getTests().asStream();
    _controller = PageController(initialPage: 0);
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
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            HomeSectionComponent(
              onPressed: () {},
              textHomeSectionComponent: test_list,
              content: StreamBuilder<List<Test>>(
                stream: _testStream,
                builder: (context, AsyncSnapshot<List<Test>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                        ),
                        width: 75,
                        height: 75,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(
                      alert_title_error,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }
                  List<Test>? tests = snapshot.data;
                  return Column(
                    children: [
                      Container(
                        height: 80,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _controller,
                          onPageChanged: (int index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          itemCount: tests!.length,
                          itemBuilder: (context, int index) {
                            UserTest? _userTest;
                            _getUserTest(newUser.id, tests[index].id).then(
                              (userTest) => userTest != null
                                  ? _userTest = userTest
                                  : _userTest = null,
                            );
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: TestItemCard(
                                    onPressed: () {
                                      _solveTest(question_route, tests[index]);
                                    },
                                    textTestItem: tests[index].title,
                                    check: _userTest != null
                                        ? _userTest!.isComplete
                                        : false,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            tests.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              child: Text('Sing Out'),
              onPressed: () {
                _signOut().then(
                  (value) =>
                      value ? Navigator.pushNamed(context, login_route) : () {},
                );
              },
            ),
            ElevatedButton(
              child: Text('Test'),
              onPressed: () {
                Navigator.pushNamed(context, test_route);
              },
            ),
            ElevatedButton(
              child: Text('Finished Test'),
              onPressed: () {
                Navigator.pushNamed(context, finished_test_route);
              },
            ),
          ],
        ),
        floatingActionButton: AppFloatingActionButton(
          onPressed: () {},
          child: getIcon(AppIcons.add),
        ),
      ),
    );
  }

  Future<bool> _signOut() async {
    bool exit = await _signOutUseCase.invoke();
    return exit;
  }

  void _getArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(context);
      return;
    }
    newUser = args[user_args];
  }

  Future<List<Test>> _getTests() async {
    List<Test> tests = await _getTestsUseCase.invoke();
    return tests;
  }

  Future<UserTest?> _getUserTest(String userId, String testId) async {
    UserTest? userTest = await _getUserTestUseCase.invoke(userId, testId);
    return userTest;
  }

  void _solveTest(String route, Test test) {
    final args = {test_args: test};
    Navigator.pushNamed(context, route, arguments: args);
  }

  Container buildDot(int index, BuildContext context) {
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
