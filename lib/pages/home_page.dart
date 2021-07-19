import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/framework/FireBase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/usecases/SignOutUseCase.dart';
import 'package:dietari/pages/login_page.dart';
import 'package:dietari/utils/arguments.dart';
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

  void _getArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(context);
      return;
    }
    newUser = args[user_args];
  }

  @override
  Widget build(BuildContext context) {
    _getArguments();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              newUser.firstName + ': Signed in Successfully ',
            ),
            RaisedButton(
              child: Text('Sing Out'),
              onPressed: () {
                _signOut().then((value) => value
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()))
                    : print(false));
              },
            )
          ],
        ),
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
}
