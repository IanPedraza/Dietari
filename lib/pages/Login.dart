import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/components/SingButton.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/ExternalUser.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/framework/FireBase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/framework/FireBase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/GetUserUseCase.dart';
import 'package:dietari/data/usecases/SendPasswordResetEmailUseCase.dart';
import 'package:dietari/data/usecases/SignInWithGoogleUseCase.dart';
import 'package:dietari/data/usecases/SignInWithEmailUseCase.dart';
import 'package:dietari/data/usecases/SignOutUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  late AuthDataSource _authDataSource = FirebaseAuthDataSource();

  late AuthRepository _authRepository =
      AuthRepository(authDataSource: _authDataSource);

  late SignInWithGoogleUseCase _signInWithGoogleUseCase =
      SignInWithGoogleUseCase(authRepository: _authRepository);

  late SignInWithEmailUseCase _signInWithEmailUseCase =
      SignInWithEmailUseCase(authRepository: _authRepository);

  late SignOutUseCase _signOutUseCase =
      SignOutUseCase(authRepository: _authRepository);

  late SendPasswordResetEmailUseCase _sendPasswordResetEmailUseCase =
      SendPasswordResetEmailUseCase(authRepository: _authRepository);

  late UserDataSource _userDataSource = FirebaseUserDataSouce();

  late UserRepository _userRepository =
      UserRepository(userDataSource: _userDataSource);

  late GetUserUseCase _getUserUseCase =
      GetUserUseCase(userRepository: _userRepository);

  TextEditingController inputControllerEmail = new TextEditingController();
  TextEditingController inputControllerPassword = new TextEditingController();

  User newUser = User(
    id: "",
    firstName: "",
    lastName: "",
    email: "",
    password: "",
    dateOfBirth: "",
    weight: 0.0,
    height: 0.0,
  );

  bool activar = true;
  @override
  Widget build(BuildContext context) {
    _signOut();
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 70, top: 40, right: 70, bottom: 10),
              child: Image.asset(image_logo),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 40, right: 30, bottom: 10),
              child: MainTextField(
                onTap: _showPassword,
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
                onTap: _showPassword,
                text: textfield_password,
                isPassword: true,
                isPasswordTextStatus: activar,
                textEditingControl: inputControllerPassword,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 10, right: 30, bottom: 10),
              child: MainButton(
                  onPressed: () {
                    _loginWithEmail();
                  },
                  text: button_login),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 0, right: 30, bottom: 10),
              child: TextButton(
                onPressed: () {
                  _sendEmailResetPassword();
                },
                child: Text(
                  text_forget_password,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 10, right: 30, bottom: 10),
              child: Text(
                text_havent_account,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 0, right: 30, bottom: 10),
              child: TextButton(
                onPressed: () {
                  _nextScreen(base_register_screen_1_route, newUser);
                },
                child: Text(
                  text_registry,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 10, right: 30, bottom: 10),
              child: SingButton(
                  onPressed: () {
                    _loginWithGoogle();
                  },
                  text: button_login_google,
                  rute: image_login_google,
                  textColor: Colors.blueAccent),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 10, right: 30, bottom: 10),
              child: SingButton(
                  onPressed: () {},
                  text: button_login_apple,
                  rute: image_login_apple,
                  textColor: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void _showPassword() {
    setState(() {
      activar = !activar;
    });
  }

  User saveGoogleUser(ExternalUser googleUser) {
    newUser.id = googleUser.uid;
    newUser.email = googleUser.email.toString();
    newUser.firstName = googleUser.displayName.toString();
    return newUser;
  }

  void _nextScreen(String route, User user) {
    final args = {user_args: user};
    Navigator.pushNamed(context, route, arguments: args);
  }

  void _loginWithEmail() {
    if (inputControllerEmail.text.isNotEmpty &&
        inputControllerPassword.text.isNotEmpty) {
      if (EmailValidator.validate(inputControllerEmail.text)) {
        _signInWithEmail(inputControllerEmail.text.toString(),
                inputControllerPassword.text.toString())
            .then(
          (userId) => userId != null
              ? (_UserRegistered(userId).then(
                  (usered) => usered != null
                      ? _nextScreen(home_route, usered)
                      : showAlertDialog(
                          alert_title_error, alert_content_not_registered),
                ))
              : showAlertDialog(alert_title_error, alert_content_incorrect),
        );
      } else {
        showAlertDialog(alert_title_error, alert_content_not_valid_email);
      }
    } else {
      showAlertDialog(alert_title_error, alert_content_email_password);
    }
  }

  void _loginWithGoogle() {
    _signInWithGoogle().then((googleUser) => googleUser != null
        ? _UserRegistered(googleUser.uid).then(
            (usered) => usered != null
                ? _nextScreen(home_route, usered)
                : _nextScreen(
                    base_register_screen_1_route, saveGoogleUser(googleUser)),
          )
        : showAlertDialog(alert_title_error, alert_content_error_login_google));
  }

  void _sendEmailResetPassword() {
    if (inputControllerEmail.text.isNotEmpty) {
      if (EmailValidator.validate(inputControllerEmail.text)) {
        _sendPasswordResetEmail(inputControllerEmail.text).then(
          (value) => value
              ? showToast(alert_title_send_email)
              : showToast(alert_title_error_not_registered),
        );
      } else {
        showAlertDialog(alert_title_error, alert_content_not_valid_email);
      }
    } else {
      showAlertDialog(alert_title_error, alert_content_email);
    }
  }

  void showToast(String content) {
    Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: primaryColor,
      fontSize: 18,
    );
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

  Future<ExternalUser?> _signInWithGoogle() async {
    ExternalUser? googleUser = await _signInWithGoogleUseCase.invoke();
    return googleUser;
  }

  Future<User?> _UserRegistered(String id) async {
    User? user = await _getUserUseCase.invoke(id);
    return user;
  }

  Future<String?> _signInWithEmail(String email, String password) async {
    String? user = await _signInWithEmailUseCase.invoke(email, password);
    return user;
  }

  Future<bool> _signOut() async {
    bool exit = await _signOutUseCase.invoke();
    return exit;
  }

  Future<bool> _sendPasswordResetEmail(String email) async {
    bool reset = await _sendPasswordResetEmailUseCase.invoke(email);
    return reset;
  }
}
