import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/pages/Base_Register_Screen_3.dart';
import 'package:flutter/material.dart';

class Base_Register_2 extends StatefulWidget {
  @override
  _Base_Register_2 createState() => _Base_Register_2();
}

class _Base_Register_2 extends State<Base_Register_2> {
  bool _active = false;

  void _showPassword() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController inputControllerLastName = new TextEditingController();
    TextEditingController inputControllerMothersLastName =
        new TextEditingController();
    TextEditingController inputControllerName = new TextEditingController();
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Base Register - 2"),
      ),*/
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: 'Apellido Paterno',
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
              text: 'Apellido Materno',
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: inputControllerMothersLastName,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: 'Nombre(s)',
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: inputControllerName,
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
                              builder: (context) => Base_Register_3()))
                    },
                text: "Continuar"),
          ),
        ],
      ),
    );
  }
}
