import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/DateTextField.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/components/ShowAlertDialog.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/usecases/AddUserUseCase.dart';
import 'package:dietari/utils/arguments.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class BaseRegister3Page extends StatefulWidget {
  const BaseRegister3Page({
    Key? key,
  }) : super(key: key);
  @override
  _BaseRegister3Page createState() => _BaseRegister3Page();
}

class _BaseRegister3Page extends State<BaseRegister3Page> {
  final _addUserUseCase = Injector.appInstance.get<AddUserUseCase>();

  TextEditingController _birthDateController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();

  late User newUser;
  double height = 0, weight = 0;

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
            child: DateTextField(
              labelText: textfield_birth_date,
              hintText: textfield_hint_birth_date,
              textEditingControl: _birthDateController,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: (){},
              text: textfield_weight,
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: _weightController,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainTextField(
              onTap: (){},
              text: textfield_height,
              isPassword: false,
              isPasswordTextStatus: false,
              textEditingControl: _heightController,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
            child: MainButton(
              onPressed: _finishRegister,
              text: button_finish,
            ),
          ),
        ],
      ),
    );
  }

  void _autocomplete() {
    if (newUser.dateOfBirth.isNotEmpty) {
      _birthDateController.text = newUser.dateOfBirth.toString();
    }
    if (newUser.weight != 0) {
      _weightController.text = newUser.weight.toString();
    }
    if (newUser.height != 0) {
      _heightController.text = newUser.height.toString();
    }
  }

  void _getArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(context);
      return;
    }
    newUser = args[user_args];
  }

  User _saveChange(String dateBirth, double weight, double height) {
    newUser.dateOfBirth = dateBirth;
    newUser.weight = weight;
    newUser.height = height;
    return newUser;
  }

  void _nextScreen(String route, User user) {
    final args = {user_args: user};
    Navigator.pushNamed(context, route, arguments: args);
  }

  void _finishRegister() {
    if (_birthDateController.text.isNotEmpty &&
        _heightController.text.isNotEmpty &&
        _weightController.text.isNotEmpty) {
      height = double.parse(_heightController.text);
      weight = double.parse(_weightController.text);
      _saveChange(_birthDateController.text.toString(), weight, height);
      _addUser(newUser).then(
        (value) => {
          if(value){
            _nextScreen(home_route, newUser)
          }else{
            _showAlertDialog(context, alert_title_error,
                    alert_content_error_registration),
                Navigator.pushNamed(context, login_route),
          }
        } 
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

  Future<bool> _addUser(User newUser) async {
    bool response = await _addUserUseCase.invoke(newUser);
    return response;
  }
}
