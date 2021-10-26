import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/TestItemCard.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/domain/UserTest.dart';
import 'package:dietari/data/usecases/GetTestsUseCase.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/GetUserTestUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _getTestsUseCase = Injector.appInstance.get<GetTestsUseCase>();
  final _getUserTestUseCase = Injector.appInstance.get<GetUserTestUseCase>();
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  
  late String? _userId;
  List<Test> _listTests = [];
  List<UserTest> _listUserTests = [];
  late Stream<List<Test>> _listTestStream;

  @override
  void initState() {
    _userId = _getUserIdUseCase.invoke();
    _listTestStream = _getTestsUseCase.invoke().asStream();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        textAppBar: test_list,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: new StreamBuilder<List<Test>>(
        stream: _listTestStream,
        builder: (BuildContext context, AsyncSnapshot<List<Test>?> snapshot) {
          if (snapshot.hasError) {
            return hasError(alert_title_error);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return waitingConnection();
          }
          if (snapshot.data!.isEmpty) {
            return hasError(alert_content_is_empty);
          } else {
            _listTests = snapshot.data!;
            _getUserTests();
            return ListView.builder(
              shrinkWrap: true,
              itemExtent: 80,
              itemCount: _listTests.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
                  child: TestItemCard(
                    onPressed: () {
                      _showDetailTest(_listTests[index]);
                    },
                    textTestItem: _listTests[index].title,
                    check: _testResolved(_listTests[index].id),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showDetailTest(Test test) {
    final args = {test_args: test};
    Navigator.pushNamed(context, test_detail_route, arguments: args);
  }

  void _getUserTests() async {
    if (mounted) {
      List<Future<UserTest?>> futures = [];
      _listTests.forEach((test) {
        Future<UserTest?> data = _getUserTestUseCase.invoke(_userId!, test.id);
        futures.add(data);
      });
      List<UserTest?> results = await Future.wait(futures);
      results.forEach((userTest) {
        if (userTest != null) {
          setState(() {
            _listUserTests.add(userTest);
          });
        }
      });
    }
  }

  bool _testResolved(String testId) {
    bool resolved = false;
    _listUserTests.forEach((userTest) {
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
