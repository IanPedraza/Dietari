import 'package:dietari/components/HomeSectionComponent.dart';
import 'package:dietari/components/TestItemCard.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/framework/FireBase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/usecases/SignOutUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
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

  late User newUser;
  int currentIndex = 0;
  late PageController _controller;

  List<Widget> _widgets = [
    TestItemCard(
      onPressed: () {},
      textTestItem: button_mna,
      check: true,
    ),
    TestItemCard(
      onPressed: () {},
      textTestItem: button_icm,
      check: false,
    ),
    TestItemCard(
      onPressed: () {},
      textTestItem: button_test3,
      check: true,
    ),
  ];

  @override
  void initState() {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          HomeSectionComponent(
            onPressed: () {},
            textHomeSectionComponent: "Tests",
            content: Container(
              height: 230,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: _widgets.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 0, top: 5, right: 20, bottom: 5),
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: _widgets[index],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 0, top: 5, right: 20, bottom: 5),
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: _widgets[index],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 0, top: 5, right: 20, bottom: 5),
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: _widgets[index],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _widgets.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          RaisedButton(
            child: Text('Sing Out'),
            onPressed: () {
              _signOut().then(
                (value) => value
                    ? Navigator.pushNamed(context, login_route)
                    : print(false),
              );
            },
          ),
          RaisedButton(
            child: Text('Test'),
            onPressed: () {
              Navigator.pushNamed(context, test_route);
            },
          ),
          RaisedButton(
            child: Text('Question'),
            onPressed: () {
              Navigator.pushNamed(context, question_route);
            },
          ),
          RaisedButton(
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
