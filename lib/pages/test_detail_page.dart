import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/domain/UserTest.dart';
import 'package:dietari/data/framework/FireBase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/framework/FireBase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/GetUserTestUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';

class TestDetailPage extends StatefulWidget {
  TestDetailPage({Key? key}) : super(key: key);

  @override
  _TestDetailPageState createState() => _TestDetailPageState();
}

class _TestDetailPageState extends State<TestDetailPage> {
  late AuthDataSource _authDataSource;
  late AuthRepository _authRepository;
  late GetUserIdUseCase _getUserIdUseCase;

  late UserDataSource _userDataSource;
  late UserRepository _userRepository;
  late GetUserTestUseCase _getUserTestUseCase;

  String? _userId;
  late Test test;
  UserTest userTest = new UserTest(title: '', questions: []);

  @override
  void initState() {
    _authDataSource = FirebaseAuthDataSource();
    _authRepository = AuthRepository(authDataSource: _authDataSource);
    _getUserIdUseCase = GetUserIdUseCase(authRepository: _authRepository);

    _userDataSource = FirebaseUserDataSouce();
    _userRepository = UserRepository(userDataSource: _userDataSource);
    _getUserTestUseCase = GetUserTestUseCase(userRepository: _userRepository);

    _userId = _getUserIdUseCase.invoke();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getArguments();
      _getUserTest();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        textAppBar: test.title,
        appBarcolor: backgroundColorTestItem,
        textColor: colorTextMainButton,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(
                left: 10, top: 10, right: 200, bottom: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: userTest.isComplete ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(45),
            ),
            child: Text(
              userTest.isComplete ? text_complete : text_no_response,
              style: TextStyle(
                color: colorTextMainButton,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text_description,
              style: TextStyle(
                color: colorTextBlack,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              test.description,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: colorTextBlack,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text_result,
              style: TextStyle(
                color: colorTextBlack,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text_without_result,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: colorTextBlack,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(10),
            child: MainButton(
              text: userTest.isComplete ? button_retry : button_start,
              onPressed: _answerTest,
            ),
          )
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
    setState(() {
      test = args[test_args];
    });
  }

  Future<void> _getUserTest() async {
    UserTest? testUser = await _getUserTestUseCase.invoke(_userId!, test.id);
    if (testUser != null) {
      setState(() {
        userTest = testUser;
      });
    }
  }

  void _answerTest() {
    final args = {test_args: test};
    Navigator.pushNamed(context, question_route, arguments: args);
  }
}
