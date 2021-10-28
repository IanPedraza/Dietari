import 'dart:io';
import 'package:dietari/components/HomeSectionComponent.dart';
import 'package:dietari/components/TestItemCard.dart';
import 'package:dietari/components/TipComponent.dart';
import 'package:dietari/data/domain/HistoryItem.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/domain/UserTest.dart';
import 'package:dietari/data/usecases/GetTestsUseCase.dart';
import 'package:dietari/data/usecases/GetUserHistoryUseCase.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/GetUserListenerUseCase.dart';
import 'package:dietari/data/usecases/GetUserTestUseCase.dart';
import 'package:dietari/data/usecases/GetUserTipsUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:dietari/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:injector/injector.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _getTestsUseCase = Injector.appInstance.get<GetTestsUseCase>();
  final _getUserTestUseCase = Injector.appInstance.get<GetUserTestUseCase>();
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  // final _getUserUseCase = Injector.appInstance.get<GetUserListenerUseCase>();
  final _getUserListenerUseCase =
      Injector.appInstance.get<GetUserListenerUseCase>();
  final _getUserTipsUseCase = Injector.appInstance.get<GetUserTipsUseCase>();
  final _getUserHistory = Injector.appInstance.get<GetUserHistoryUseCase>();

  // late String _userName = "";
  // late String _userStatus = "";

  // List<HistoryItem> _userHistory = [];

  late Stream<User?> _getUser;

  late String? _userId;

  late User newUser;
  List<UserTest> _userTests = [];

  late List<Test> _tests;
  ScrollController _controllerTest = ScrollController(initialScrollOffset: 0);
  ScrollController _controllerTips = ScrollController(initialScrollOffset: 0);
  late Stream<List<Test>> _testStream;
  late TooltipBehavior _tooltipBehavior;

  var _listY = ['IMC', 'Peso', 'Estatura'];
  var _viewY = "IMC";
  var _listX = ['Dia', 'Semana', 'Mes', 'Año'];
  var _viewX = "Mes";

  @override
  void initState() {
    _userId = _getUserIdUseCase.invoke();
    _testStream = _getTests().asStream();

    _getUser = _getUserListenerUseCase.invoke(_userId!);

    _tooltipBehavior = TooltipBehavior(enable: true);

    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getArguments();
    });
  }

  @override
  void dispose() {
    _controllerTest.dispose();
    _controllerTips.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              StreamBuilder<User?>(
                stream: _getUser,
                builder: (context, data) {
                  if (data.hasData && data.data != null) {
                    return _userDataContainer(data.data!);
                  }

                  return Container();
                },
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 50, left: 15),
                    child: Text(
                      text_ChartTitle,
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: primaryColor,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: colorTextMainButton),
                              ),
                              child: DropdownButton(
                                underline: SizedBox(),
                                icon: getIcon(AppIcons.arrow_down,
                                    color: primaryColor),
                                iconSize: 30,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w900),
                                items: _listY.map((String a) {
                                  return DropdownMenuItem(
                                    value: a,
                                    child: Text(a),
                                  );
                                }).toList(),
                                onChanged: (_value) => {
                                  setState(() {
                                    _viewY = _value.toString();
                                  })
                                },
                                hint: Text(
                                  _viewY,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ),
                        ),
                        StreamBuilder<List<HistoryItem>>(
                          stream: _getUserHistory.invoke(_userId!),
                          builder: (context, data) {
                            return _chart(data.data ?? []);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 0),
                    alignment: Alignment.center,
                    child: DropdownButton(
                      underline: SizedBox(),
                      icon: getIcon(AppIcons.arrow_down, color: primaryColor),
                      iconSize: 30,
                      style: TextStyle(
                          fontSize: 15,
                          color: primaryColor,
                          fontWeight: FontWeight.w900),
                      items: _listX.map((String a) {
                        return DropdownMenuItem(
                          value: a,
                          child: Text(a),
                        );
                      }).toList(),
                      onChanged: (_value) => {
                        setState(() {
                          _viewX = _value.toString();
                        })
                      },
                      hint: Text(
                        _viewX,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
              HomeSectionComponent(
                onPressed: () {
                  Navigator.pushNamed(context, tips_list_route);
                },
                textHomeSectionComponent: tips_list,
                content: new StreamBuilder<List<Tip>>(
                  stream: _getUserTipsUseCase.invoke(_userId!),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Tip>> snapshot) {
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
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
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
                content: StreamBuilder<List<Test>>(
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

                      if (_userTests.isEmpty) {
                        _getUserTests();
                      }

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
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
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
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: getIcon(AppIcons.edit),
          onPressed: _openEditData,
          backgroundColor: primaryColor,
        ),
      ),
    );
  }

  void _openEditData() {
    Navigator.pushNamed(context, edit_data_route);
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

  void _getUserTests() async {
    List<Future<UserTest?>> futures = [];

    _tests.forEach((test) {
      Future<UserTest?> data = _getUserTestUseCase.invoke(_userId!, test.id);
      futures.add(data);
    });

    List<UserTest?> results = await Future.wait(futures);

    results.forEach((userTest) {
      if (userTest != null) {
        _userTests.add(userTest);
      }
    });

    setState(() {});
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

  Widget waitingConnection() {
    return Container(
      child: Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 5,
          ),
          width: 75,
          height: 75,
        ),
      ),
    );
  }

  Widget hasError(String text) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _userDataContainer(User user) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 15, bottom: 0),
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
                text: user.firstName,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 27,
                ),
              ),
              TextSpan(text: "\n"),
              TextSpan(
                text: user.status,
                style: TextStyle(
                  color: colorStatus,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ]),
          ),
          Spacer(),
          FloatingActionButton(
            mini: true,
            child: Container(
              child: getIcon(AppIcons.settings, color: colorBlack),
            ),
            onPressed: () {
              Navigator.pushNamed(context, settings_route);
            },
            backgroundColor: colorTextMainButton,
            // elevation: 0,
          ),
        ],
      ),
    );
  }

  Widget _chart(List<HistoryItem> userHistory) {
    return Container(
      alignment: Alignment.center,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        // Chart title
        //title: ChartTitle(text:"Tu historial."),
        // Enable legend
        legend: Legend(isVisible: false),
        tooltipBehavior: _tooltipBehavior,
        series: <LineSeries<HistoryItem, String>>[
          LineSeries<HistoryItem, String>(
              dataSource: userHistory,
              yValueMapper: (_viewY == "IMC")
                  ? (HistoryItem num, _) => num.imc
                  : (_viewY == "Peso")
                      ? (HistoryItem num, _) => num.weight
                      : (HistoryItem num, _) => num.height,
              xValueMapper: (_viewX == "Mes")
                  ? (HistoryItem num, _) => num.date.toDate().month.toString()
                  : (_viewX == "Dia")
                      ? (HistoryItem num, _) => num.date.toDate().day.toString()
                      : (_viewX == "Semana")
                          ? (HistoryItem num, _) =>
                              num.date.toDate().weekday.toString()
                          : (HistoryItem num, _) =>
                              num.date.toDate().year.toString(),
              pointColorMapper: (HistoryItem num, _) => primaryColor,
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
