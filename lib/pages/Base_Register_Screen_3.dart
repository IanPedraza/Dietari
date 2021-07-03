import 'package:dietari/components/DateTextField.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/pages/Login.dart';
import 'package:flutter/material.dart';

class Base_Register_3 extends StatefulWidget {
  @override
  _Base_Register_3 createState() => _Base_Register_3();
}

class _Base_Register_3 extends State<Base_Register_3> {
  bool _active = false;

  void _showPassword() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController inputControllerBirthDate =
        new TextEditingController();
    TextEditingController inputControllerWeight = new TextEditingController();
    TextEditingController inputControllerHeight = new TextEditingController();
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Base Register - 2"),
      ),*/
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: DateTextField(
              labelText: 'Fecha de Nacimiento',
              hintText: 'Ingrese Fecha de Nacimiento',
              textEditingControl: inputControllerBirthDate,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: _showPassword,
              text: 'Peso(kg)',
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
              text: 'Estatura(m)',
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: inputControllerHeight,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 30, top: 400, right: 30, bottom: 10),
            child: MainButton(
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()))
                    },
                text: "Terminar"),
          ),
        ],
      ),
    );
  }
}
