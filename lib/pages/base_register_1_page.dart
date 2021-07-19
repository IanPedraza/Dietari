import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/components/ShowAlertDialog.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/framework/FireBase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/framework/FireBase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/usecases/SignUpWithEmailUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class BaseRegister1 extends StatefulWidget {
  const BaseRegister1({
    Key? key,
  }) : super(key: key);
  @override
  _BaseRegister1 createState() => _BaseRegister1();
}

class _BaseRegister1 extends State<BaseRegister1> {
  late AuthDataSource _authDataSource = FirebaseAuthDataSource();

  late UserDataSource _userDataSource = FirebaseUserDataSouce();

  late AuthRepository _authRepository =
      AuthRepository(authDataSource: _authDataSource);

  late GetUserIdUseCase _getUserIdUseCase =
      GetUserIdUseCase(authRepository: _authRepository);

  late UserRepository _userRepository =
      UserRepository(userDataSource: _userDataSource);

  late SignUpWithEmailUseCase _signUpWithEmailUseCase =
      SignUpWithEmailUseCase(authRepository: _authRepository);

  TextEditingController inputControllerEmail = new TextEditingController();
  TextEditingController inputControllerPassword = new TextEditingController();
  TextEditingController inputControllerRepeatPassword =
      new TextEditingController();

  late User newUser;

  bool activar1 = true;
  bool activar2 = true;

  @override
  Widget build(BuildContext context) {
    _getArguments();
    return Scaffold(
      appBar: AppBar(
        title: Text(registration_form),
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
              textEditingControl: inputControllerEmail,
            ),
          ),
          Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 10, right: 30, bottom: 10),
              child: MainTextField(
                  text: textfield_password,
                  isPassword: true,
                  isPasswordTextStatus: activar1,
                  textEditingControl: inputControllerPassword,
                  onTap: _showPassword1)),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword2,
              text: textfield_repeat_password,
              isPassword: true,
              isPasswordTextStatus: activar2,
              textEditingControl: inputControllerRepeatPassword,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
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

  void _showPassword1() {
    setState(() {
      activar1 = !activar1;
    });
  }

  void _showPassword2() {
    setState(() {
      activar2 = !activar2;
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
    newUser.password = password;
    return newUser;
  }

  void _nextScreen(String route, User user) {
    final args = {user_args: user};
    Navigator.pushNamed(context, route, arguments: args);
  }

  void _continueRegister() {
    if (inputControllerEmail.text.isNotEmpty &&
        inputControllerPassword.text.isNotEmpty &&
        inputControllerRepeatPassword.text.isNotEmpty) {
      if (EmailValidator.validate(inputControllerEmail.text)) {
        if (inputControllerPassword.text ==
            inputControllerRepeatPassword.text) {
          _getUserId().then(
            (iduser) => iduser != null
                ? _nextScreen(
                    base_register_2_route,
                    _saveChange(
                      inputControllerEmail.text.toString(),
                      inputControllerPassword.text.toString(),
                      iduser,
                    ),
                  )
                : _signUpWithEmail(
                        inputControllerEmail.text, inputControllerPassword.text)
                    .then(
                    (idvalue) => idvalue != null
                        ? _nextScreen(
                            base_register_2_route,
                            _saveChange(
                              inputControllerEmail.text.toString(),
                              inputControllerPassword.text.toString(),
                              idvalue,
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
    String? id = await _getUserIdUseCase.invoke();
    return id;
  }

  Future<String?> _signUpWithEmail(String email, String password) async {
    String? user = await _signUpWithEmailUseCase.invoke(email, password);
    return user;
  }
}
