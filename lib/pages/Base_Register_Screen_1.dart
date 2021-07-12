import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/framework/FireBase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/framework/FireBase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/GetUserUseCase.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/usecases/SignUpWithEmailUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Base_Register_1 extends StatefulWidget {
  const Base_Register_1({
    Key? key,
  }) : super(key: key);
  @override
  _Base_Register_1 createState() => _Base_Register_1();
}

class _Base_Register_1 extends State<Base_Register_1> {
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

  late GetUserUseCase _getUserUseCase =
      GetUserUseCase(userRepository: _userRepository);

  TextEditingController inputControllerEmail = new TextEditingController();
  TextEditingController inputControllerPassword = new TextEditingController();
  TextEditingController inputControllerRepeatPassword =
      new TextEditingController();

  late User newUser;

  bool activar1 = true;
  bool activar2 = true;

  String? Id = null;
  @override
  Widget build(BuildContext context) {
    _getArguments();
    _autocomplete();
    final args = {user_args: newUser};
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: showPassword1,
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
                  onTap: showPassword1)),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: showPassword2,
              text: textfield_repeat_password,
              isPassword: true,
              isPasswordTextStatus: activar2,
              textEditingControl: inputControllerRepeatPassword,
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
    if (newUser.email.isNotEmpty) {
      inputControllerEmail.text = newUser.email.toString();
    }
    if (newUser.password.isNotEmpty) {
      inputControllerPassword.text = newUser.password.toString();
    }
  }

  void showPassword1() {
    setState(() {
      activar1 = !activar1;
    });
  }

  void showPassword2() {
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

  User saveChange(String email, String password, String id) {
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
                    base_register_screen_2_route,
                    saveChange(
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
                            base_register_screen_2_route,
                            saveChange(
                              inputControllerEmail.text.toString(),
                              inputControllerPassword.text.toString(),
                              idvalue,
                            ),
                          )
                        : showAlertDialog(
                            alert_title_error, alert_content_email_used),
                  ),
          );
        } else {
          showAlertDialog(alert_title_error, alert_content_incorrect_password);
        }
      } else {
        showAlertDialog(alert_title_error, alert_content_not_valid_email);
      }
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

  Future<User?> _UserRegistered(String id) async {
    User? user = await _getUserUseCase.invoke(id);
    return user;
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
