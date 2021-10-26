import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/components/ShowAlertDialog.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/SignUpWithEmailUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:injector/injector.dart';

class BaseRegister1Page extends StatefulWidget {
  const BaseRegister1Page({
    Key? key,
  }) : super(key: key);
  @override
  _BaseRegister1Page createState() => _BaseRegister1Page();
}

class _BaseRegister1Page extends State<BaseRegister1Page> {
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _signUpWithEmailUseCase = Injector.appInstance.get<SignUpWithEmailUseCase>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _repeatPasswordController = new TextEditingController();

  late User newUser;
  bool active1 = true;
  bool active2 = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getArguments();
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
              onTap: _showPassword1,
              text: textfield_email,
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: _emailController,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              text: textfield_password,
              isPassword: true,
              isPasswordTextStatus: active1,
              textEditingControl: _passwordController,
              onTap: _showPassword1,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword2,
              text: textfield_repeat_password,
              isPassword: true,
              isPasswordTextStatus: active2,
              textEditingControl: _repeatPasswordController,
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

  void _showPassword1() {
    setState(() {
      active1 = !active1;
    });
  }

  void _showPassword2() {
    setState(() {
      active2 = !active2;
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

  User _saveChange(String email, String password, String id) {
    newUser.id = id;
    newUser.email = email;
    return newUser;
  }

  void _nextScreen(String route, User user) {
    final args = {user_args: user};
    Navigator.pushNamed(context, route, arguments: args);
  }

  void _continueRegister() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _repeatPasswordController.text.isNotEmpty) {
      _emailController.text = _emailController.text.split(' ').first;
      if (EmailValidator.validate(_emailController.text)) {
        if (_passwordController.text == _repeatPasswordController.text) {
          _getUserId().then(
            (idUser) => idUser != null
                ? _nextScreen(
                    base_register_2_route,
                    _saveChange(
                      _emailController.text.toString(),
                      _passwordController.text.toString(),
                      idUser,
                    ),
                  )
                : _signUpWithEmail(
                        _emailController.text, _passwordController.text)
                    .then(
                    (idValue) => idValue != null
                        ? _nextScreen(
                            base_register_2_route,
                            _saveChange(
                              _emailController.text.toString(),
                              _passwordController.text.toString(),
                              idValue,
                            ),
                          )
                        : _showAlertDialog(context, alert_title_error,
                            alert_content_email_used),
                  ),
          );
        } else {
          _showAlertDialog(
              context, alert_title_error, alert_content_incorrect_password);
        }
      } else {
        _showAlertDialog(
            context, alert_title_error, alert_content_not_valid_email);
      }
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

  Future<String?> _getUserId() async {
    String? id = _getUserIdUseCase.invoke();
    return id;
  }

  Future<String?> _signUpWithEmail(String email, String password) async {
    String? user = await _signUpWithEmailUseCase.invoke(email, password);
    return user;
  }
}
