import 'dart:io';
import 'package:dietari/components/HomeSectionComponent.dart';
import 'package:dietari/components/TestItemCard.dart';
import 'package:dietari/components/TipComponent.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/datasources/TestsDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/domain/UserTest.dart';
import 'package:dietari/data/framework/firebase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/framework/firebase/FirebaseTestsDataSource.dart';
import 'package:dietari/data/framework/firebase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/repositories/TestsRepository.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/GetTestsUseCase.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/GetUserTestUseCase.dart';
import 'package:dietari/data/usecases/GetUserTipsUseCase.dart';
import 'package:dietari/data/usecases/GetUserUseCase.dart';
import 'package:dietari/data/usecases/SignOutUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:dietari/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthDataSource _authDataSource;
  late AuthRepository _authRepository;
  late SignOutUseCase _signOutUseCase;
  late TestsDataSource _testsDataSource;
  late TestsRepository _testsRepository;
  late GetTestsUseCase _getTestsUseCase;
  late UserDataSource _userDataSource;
  late UserRepository _userRepository;
  late GetUserTestUseCase _getUserTestUseCase;
  late GetUserIdUseCase _getUserIdUseCase;
  late GetUserTipsUseCase _getUserTipsUseCase;

  late GetUserUseCase _getUserUseCase =
      GetUserUseCase(userRepository: _userRepository);

  late String _userName = "";
  late String _userStatus = "";

  late String? _userId;
  late User newUser;
  List<UserTest> _userTests = [];

  late List<Test> _tests;
  ScrollController _controllerTest = ScrollController(initialScrollOffset: 0);
  ScrollController _controllerTips = ScrollController(initialScrollOffset: 0);
  late Stream<List<Test>> _testStream;
  late Stream<List<Tip>> _tipStream;

  @override
  void initState() {
    _authDataSource = FirebaseAuthDataSource();
    _authRepository = AuthRepository(authDataSource: _authDataSource);
    _signOutUseCase = SignOutUseCase(authRepository: _authRepository);

    _testsDataSource = FirebaseTestsDataSource();
    _testsRepository = TestsRepository(testsDataSource: _testsDataSource);
    _getTestsUseCase = GetTestsUseCase(testsRepository: _testsRepository);

    _userDataSource = FirebaseUserDataSouce();
    _userRepository = UserRepository(userDataSource: _userDataSource);
    _getUserTestUseCase = GetUserTestUseCase(userRepository: _userRepository);
    _getUserIdUseCase = GetUserIdUseCase(authRepository: _authRepository);
    _getUserTipsUseCase = GetUserTipsUseCase(userRepository: _userRepository);

    _userId = _getUserIdUseCase.invoke();
    _testStream = _getTests().asStream();
    _tipStream = _getTips().asStream();
    _getUserInfo();
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
            //Home user data
            Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 15, bottom: 0),
              child: Row(
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: text_welcome,
                        style: TextStyle(
                            color: colorBlack,
                            fontWeight: FontWeight.w900,
                            fontSize: 27),
                      ),
                      TextSpan(
                        //text: "Nombre",
                        text: _userName,
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 27),
                      ),
                      TextSpan(text: "\n"),
                      TextSpan(
                          text: _userStatus,
                          style: TextStyle(
                              color: colorStatus,
                              fontWeight: FontWeight.w900,
                              fontSize: 20))
                    ]),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    mini: true,
                    child: Container(
                      child: Transform.scale(
                        scale: 1.3,
                        child: getIcon(AppIcons.settings, color: colorBlack),
                        alignment: Alignment.center,
                      ),
                    ),
                    onPressed: () {},
                    backgroundColor: colorTextMainButton,
                    elevation: 0,
                  ),
                ],
              ),
            ),

            HomeSectionComponent(
              onPressed: () {
                Navigator.pushNamed(context, tips_list_route);
              },
              textHomeSectionComponent: tips_list,
              content: new StreamBuilder<List<Tip>>(
                stream: _tipStream,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Tip>> snapshot) {
                  if (snapshot.hasError) {
                    return hasError(alert_title_error);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return waitingConnection();
                  }
                  if (snapshot.data!.isEmpty) {
                    return hasError(alert_content_is_empty);
                  } else {
                    List<Tip>? _tips = snapshot.data;
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
                            itemCount: _tips!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    child: TipComponent(
                                      tip: _tips[index],
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
                  }
                },
              ),
            ),
            HomeSectionComponent(
              onPressed: () {
                Navigator.pushNamed(context, test_route);
              },
              textHomeSectionComponent: test_list,
              content: new StreamBuilder<List<Test>>(
                stream: _testStream,
                builder: (context, AsyncSnapshot<List<Test>?> snapshot) {
                  if (snapshot.hasError) {
                    return hasError(alert_title_error);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return waitingConnection();
                  }
                  if (snapshot.data!.isEmpty) {
                    return hasError(alert_content_is_empty);
                  } else {
                    _tests = snapshot.data!;
                    _getUserTests();
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
                            itemCount: _tests.length,
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
                                        _showDetailTest(_tests[index]);
                                      },
                                      textTestItem: _tests[index].title,
                                      check: _testResolved(_tests[index].id),
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
                  }
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
          ],
        ),
      ),
    );
  }

  Future<bool> _signOut() async {
    bool exit = await _signOutUseCase.invoke();
    return exit;
  }

  void _showDetailTest(Test test) {
    final args = {test_args: test};
    Navigator.pushNamed(context, test_detail_route, arguments: args);
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

  void _showAllTests() {
    Navigator.pushNamed(context, test_route);
  }

  void _answerTest(String route, Test test) {
    final args = {test_args: test};
    Navigator.pushNamed(context, route, arguments: args);
  }

  Future<List<Tip>> _getTips() async {
    List<Tip> tips = await _getUserTipsUseCase.invoke(_userId!);
    return tips;
  }

  /*Future <String> _getUserInfo() async {
    User info = (await _getUserUseCase.invoke(_userId!))!;
    return _userName = info.firstName.toString();
  } */

  void _getUserInfo() async {
    User info = (await _getUserUseCase.invoke(_userId!))!;
    setState(() {
      _userName = info.firstName.toString();
      _userStatus = info.status.toString();
    });
  }

  void _getUserTests() async {
    List<Future<UserTest?>> futures = [];
    _tests.forEach((test) {
      Future<UserTest?> data = _getUserTestUseCase.invoke(_userId!, test.id);
      futures.add(data);
    });
    List<UserTest?> results = await Future.wait(futures);
    results.forEach((userTest) {
      if (userTest != null) {
        setState(() {
          _userTests.add(userTest);
        });
      }
    });
  }

  bool _testResolved(String testId) {
    bool resolved = false;
    _userTests.forEach((userTest) {
      if (userTest.id == testId) {
        resolved = true;
      }
    });
    return resolved;
  }

  Center waitingConnection() {
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

  Center hasError(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
