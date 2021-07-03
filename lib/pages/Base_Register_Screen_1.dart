import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/pages/Base_Register_Screen_2.dart';
import 'package:flutter/material.dart';

class Base_Register_1 extends StatefulWidget {
  @override
  _Base_Register_1 createState() => _Base_Register_1();
}

class _Base_Register_1 extends State<Base_Register_1> {
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
    TextEditingController inputControllerRepeatPassword =
        new TextEditingController();
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Base Register - 1"),
      ),*/
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: 'Correo Eletrónico',
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: inputControllerEmail,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: 'Contraseña',
              isPassword: true,
              isPasswordTextStatus: true,
              textEditingControl: inputControllerPassword,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: 'Repetir Contraseña',
              isPassword: true,
              isPasswordTextStatus: true,
              textEditingControl: inputControllerRepeatPassword,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 30, top: 400, right: 30, bottom: 10),
            child: MainButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Base_Register_2()))
                    },
                text: "Continuar"),
          ),
        ],
      ),
    );
  }
}
