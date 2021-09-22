import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietari/components/HomeSectionComponent.dart';
import 'package:dietari/components/TestItemCard.dart';
import 'package:dietari/components/TipComponent.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/datasources/TestsDataSource.dart';
import 'package:dietari/data/datasources/TipsDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/domain/UserTest.dart';
import 'package:dietari/data/framework/FireBase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/framework/FireBase/FirebaseConstants.dart';
import 'package:dietari/data/framework/FireBase/FirebaseTestsDataSource.dart';
import 'package:dietari/data/framework/FireBase/FirebaseTipsDataSource.dart';
import 'package:dietari/data/framework/FireBase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/repositories/TestsRepository.dart';
import 'package:dietari/data/repositories/TipsRepository.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/GetTestsUseCase.dart';
import 'package:dietari/data/usecases/GetTipsUseCase.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/GetUserTestUseCase.dart';
import 'package:dietari/data/usecases/GetUserTipsUseCase.dart';
import 'package:dietari/data/usecases/SignOutUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  late GetUserIdUseCase _getUserIdUseCase =
      GetUserIdUseCase(authRepository: _authRepository);

  late TipsDataSource _tipsDataSource = FirebaseTipsDataSource();

  late TipsRepository _tipsRepository =
      TipsRepository(tipsDataSource: _tipsDataSource);

  late GetTipsUseCase _getTipsUseCase =
      GetTipsUseCase(tipsRepository: _tipsRepository);

  late GetUserTipsUseCase _getUserTipsUseCase =
      GetUserTipsUseCase(userRepository: _userRepository);

  late User newUser;
  int currentIndexTests = 0;
  int currentIndexTips = 0;
  ScrollController _controllerTest = ScrollController(initialScrollOffset: 0);
  ScrollController _controllerTips = ScrollController(initialScrollOffset: 0);
  late Stream<List<Test>> _testStream;
  late Stream<QuerySnapshot> _tipStream;
  List<Tip> _tips = [];

  @override
  void initState() {
    _testStream = _getTests().asStream();
    _tipStream =
        FirebaseFirestore.instance.collection(COLLECTION_TIPS).snapshots();
    super.initState();
  }

  @override
  void dispose() {
    _controllerTest.dispose();
    _controllerTips.dispose();
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
              textHomeSectionComponent: tips_list,
              content: new StreamBuilder<QuerySnapshot>(
                stream: _tipStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  _tips = [];
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Tip _tip =
                        Tip.fromMap(document.data() as Map<String, dynamic>);
                    if (newUser.tips.contains(_tip.id)) {
                      _tips.add(_tip);
                    }
                  }).toList();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _controllerTips,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2 / 8,
                          ),
                          itemCount: _tips.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: TipComponent(
                                    onPressed: () {},
                                    textTip: _tips[index].title,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 2),
                    ],
                  );
                },
              ),
            ),
            HomeSectionComponent(
              onPressed: () {},
              textHomeSectionComponent: test_list,
              content: new StreamBuilder<List<Test>>(
                stream: _testStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Test>?> snapshot) {
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
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _controllerTest,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2 / 8,
                          ),
                          itemCount: tests!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: TestItemCard(
                                    onPressed: () {
                                      _solveTest(question_route, tests[index]);
                                    },
                                    textTestItem: tests[index].title,
                                    check: _existsUserTest(tests[index].id),
                                  ),
                                ),
                              ],
                            );
                          },
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

  bool _existsUserTest(String testId) {
    bool exists = false;
    _getUserTest(newUser.id, testId)
        .then((userTest) => userTest != null ? exists = true : exists = false);
    return exists;
  }

  void _solveTest(String route, Test test) {
    final args = {test_args: test};
    Navigator.pushNamed(context, route, arguments: args);
  }

  Future<List<Tip>> _getTips() async {
    List<Tip> tips =
        await _getUserTipsUseCase.invoke(_getUserIdUseCase.invoke()!);
    return tips;
  }

  Container buildDot(int currentIndex, int index, BuildContext context) {
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
