import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/components/ShowAlertDialog.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';

class BaseRegister2Page extends StatefulWidget {
  const BaseRegister2Page({
    Key? key,
  }) : super(key: key);

  @override
  _BaseRegister2Page createState() => _BaseRegister2Page();
}

class _BaseRegister2Page extends State<BaseRegister2Page> {
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _lastNameMController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();

  late User newUser;
  bool active = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getArguments();
      _autocomplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarComponent(
        textAppBar: registration_form,
        textsize: 25,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
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
              textEditingControl: _lastNameController,
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
              textEditingControl: _lastNameMController,
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
              textEditingControl: _nameController,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainButton(
              onPressed: () {
                _continueRegister();
              },
              text: button_continue,
            ),
          ),
        ],
      ),
    );
  }

  void _autocomplete() {
    if (newUser.firstName.isNotEmpty) {
      _nameController.text = newUser.firstName.toString();
    }
    if (newUser.lastName.isNotEmpty) {
      String text = newUser.lastName.toString();
      List<String> lastName = text.split(' ');
      if (lastName.length == 1) {
        _lastNameController.text = lastName.single;
      } else {
        if (lastName.length >= 2) {
          _lastNameController.text =
              lastName.sublist(0, lastName.length - 1).join(' ');
          _lastNameMController.text = lastName.last;
        }
      }
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

  User _saveChange(String firstName, String lastName) {
    newUser.firstName = firstName;
    newUser.lastName = lastName;
    return newUser;
  }

  void _nextScreen(String route, User user) {
    final args = {user_args: user};
    Navigator.pushNamed(context, route, arguments: args);
  }

  void _continueRegister() {
    if (_lastNameController.text.isNotEmpty &&
        _lastNameMController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      _nextScreen(
        base_register_3_route,
        _saveChange(
            _nameController.text.toString(),
            _lastNameController.text.toString() +
                espace +
                _lastNameMController.text.toString()),
      );
    } else {
      _showAlertDialog(context, alert_title_error, alert_content_imcomplete);
    }
  }

  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowAlertDialog(
          title: title,
          content: content,
        );
      },
    );
  }
}
