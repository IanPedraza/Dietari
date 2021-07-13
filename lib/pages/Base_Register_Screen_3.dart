import 'package:dietari/components/DateTextField.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/framework/FireBase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/AddUserUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';

class Base_Register_3 extends StatefulWidget {
  const Base_Register_3({
    Key? key,
  }) : super(key: key);
  @override
  _Base_Register_3 createState() => _Base_Register_3();
}

class _Base_Register_3 extends State<Base_Register_3> {
  late UserDataSource _userDataSource = FirebaseUserDataSouce();

  late UserRepository _userRepository =
      UserRepository(userDataSource: _userDataSource);

  late AddUserUseCase _addUserUseCase =
      AddUserUseCase(userRepository: _userRepository);

  TextEditingController inputControllerBirthDate = new TextEditingController();
  TextEditingController inputControllerWeight = new TextEditingController();
  TextEditingController inputControllerHeight = new TextEditingController();

  late User newUser;

  bool active = true;
  double height = 0, weight = 0;

  @override
  Widget build(BuildContext context) {
    _getArguments();
    _autocomplete();
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: DateTextField(
              labelText: textfield_birth_date,
              hintText: textfield_hint_birth_date,
              textEditingControl: inputControllerBirthDate,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: textfield_weight,
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: inputControllerWeight,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: textfield_height,
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: inputControllerHeight,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 30, top: 400, right: 30, bottom: 10),
            child: MainButton(
                onPressed: () {
                  _finishRegister();
                },
                text: button_finish),
          ),
        ],
      ),
    );
  }

  void _autocomplete() {
    if (newUser.dateOfBirth.isNotEmpty) {
      inputControllerBirthDate.text = newUser.dateOfBirth.toString();
    }
    if (newUser.weight != 0) {
      inputControllerWeight.text = newUser.weight.toString();
    }
    if (newUser.height != 0) {
      inputControllerHeight.text = newUser.height.toString();
    }
  }

  void _showPassword() {
    setState(() {
      active = !active;
    });
  }

  void _getArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(context);
      return;
    }
    newUser = args[user_args];
  }

  User saveChange(String dateBirth, double weight, double height) {
    newUser.dateOfBirth = dateBirth;
    newUser.weight = weight;
    newUser.height = height;
    return newUser;
  }

  void _nextScreen(String route, User user) {
    final args = {user_args: user};
    Navigator.pushNamed(context, route, arguments: args);
  }

  void _finishRegister() {
    if (inputControllerBirthDate.text.isNotEmpty &&
        inputControllerHeight.text.isNotEmpty &&
        inputControllerWeight.text.isNotEmpty) {
      height = double.parse(inputControllerHeight.text);
      weight = double.parse(inputControllerWeight.text);
      saveChange(inputControllerBirthDate.text.toString(), weight, height);
      _addUser(newUser).then(
        (value) => value
            ? _nextScreen(home_route, newUser)
            : [
                showAlertDialog(
                    alert_title_error, alert_content_error_registration),
                Navigator.pushNamed(context, login_route),
              ],
      );
    } else {
      showAlertDialog(alert_title_error, alert_content_imcomplete);
    }
  }

  void showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          content: Text(
            content,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                text_accept,
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
    );
  }

  Future<bool> _addUser(User newUser) async {
    bool response = await _addUserUseCase.invoke(newUser);
    return response;
  }
}
