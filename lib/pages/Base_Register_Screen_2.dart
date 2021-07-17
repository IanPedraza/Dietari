import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';

class Base_Register_2 extends StatefulWidget {
  const Base_Register_2({
    Key? key,
  }) : super(key: key);

  @override
  _Base_Register_2 createState() => _Base_Register_2();
}

class _Base_Register_2 extends State<Base_Register_2> {
  TextEditingController inputControllerLastName = new TextEditingController();
  TextEditingController inputControllerMsLastName = new TextEditingController();
  TextEditingController inputControllerName = new TextEditingController();

  late User newUser;

  bool active = true;

  @override
  Widget build(BuildContext context) {
    _getArguments();
    _autocomplete();
    //escribir();
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: textfield_last_name,
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: inputControllerLastName,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: textfield_mlast_name,
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: inputControllerMsLastName,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: textfield_name,
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: inputControllerName,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 30, top: 400, right: 30, bottom: 10),
            child: MainButton(
                onPressed: () {
                  _continueRegister();
                },
                text: button_continue),
          ),
        ],
      ),
    );
  }

  void _autocomplete() {
    if (newUser.firstName.isNotEmpty) {
      inputControllerName.text = newUser.firstName.toString();
    }
    if (newUser.lastName.isNotEmpty) {
      inputControllerLastName.text = newUser.lastName.toString();
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

  User saveChange(String firstName, String lastName) {
    newUser.firstName = firstName;
    newUser.lastName = lastName;
    return newUser;
  }

  void _nextScreen(String route, User user) {
    final args = {user_args: user};
    Navigator.pushNamed(context, route, arguments: args);
  }

  void _continueRegister() {
    if (inputControllerLastName.text.isNotEmpty &&
        inputControllerMsLastName.text.isNotEmpty &&
        inputControllerName.text.isNotEmpty) {
      _nextScreen(
        base_register_screen_3_route,
        saveChange(
            inputControllerName.text.toString(),
            inputControllerLastName.text.toString() +
                espace +
                inputControllerMsLastName.text.toString()),
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
            ),
          ],
        );
      },
    );
  }
}