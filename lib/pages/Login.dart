import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/pages/Base_Register_Screen_1.dart';
import 'package:dietari/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  bool _active = false;

  void _showPassword() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController inputControllerEmail = new TextEditingController();
    TextEditingController inputControllerPassword = new TextEditingController();
    new TextEditingController();

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 70, top: 10, right: 70, bottom: 10),
              child: Image.asset(
                'logo.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 10, right: 30, bottom: 10),
              child: MainTextField(
                onTap: _showPassword,
                text: 'Correo Electronico',
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
                text: 'Contraseña',
                isPassword: true,
                isPasswordTextStatus: true,
                textEditingControl: inputControllerPassword,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 10, right: 30, bottom: 10),
              child: MainButton(onPressed: () => {}, text: "Iniciar Sesión"),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 10, right: 30, bottom: 10),
              child: Text(
                '¿Aun no Tienes Cuenta?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(
                    left: 30, top: 0, right: 30, bottom: 10),
                child: TextButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Base_Register_1()))
                  },
                  child: Text(
                    'Registrarse',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
