import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/MainButton.dart';
import 'package:dietari/components/MainTextField.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/GetUserUseCase.dart';
import 'package:dietari/data/usecases/UpdateUserUseCase.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injector/injector.dart';

class EditDataPage extends StatefulWidget {
  const EditDataPage({Key? key}) : super(key: key);

  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final _getUserUseCase = Injector.appInstance.get<GetUserUseCase>();
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _updateUserUseCase = Injector.appInstance.get<UpdateUserUseCase>();

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String? _nameError;
  String? _lastNameError;
  String? _weightError;
  String? _heightError;

  bool _isLoading = true;
  User? _user;

  final _padding = const EdgeInsets.only(
    left: 30,
    top: 10,
    right: 30,
    bottom: 10,
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBarComponent(
        textAppBar: edit_data,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  padding: _padding,
                  child: MainTextField(
                    text: textfield_name,
                    isPassword: false,
                    textEditingControl: _nameController,
                    isPasswordTextStatus: false,
                    onTap: () {},
                    errorText: _nameError,
                  ),
                ),
                Container(
                  padding: _padding,
                  child: MainTextField(
                    text: textfield_lastname,
                    isPassword: false,
                    textEditingControl: _lastNameController,
                    isPasswordTextStatus: false,
                    onTap: () {},
                    errorText: _lastNameError,
                  ),
                ),
                Container(
                  padding: _padding,
                  child: MainTextField(
                    text: textfield_weight,
                    isPassword: false,
                    isNumber: true,
                    textEditingControl: _weightController,
                    isPasswordTextStatus: false,
                    onTap: () {},
                    errorText: _weightError,
                  ),
                ),
                Container(
                  padding: _padding,
                  child: MainTextField(
                    text: textfield_height,
                    isPassword: false,
                    isNumber: true,
                    textEditingControl: _heightController,
                    isPasswordTextStatus: false,
                    onTap: () {},
                    errorText: _heightError,
                  ),
                ),
                Container(
                  padding: _padding,
                  child: MainButton(
                    text: save,
                    onPressed: _saveData,
                  ),
                )
              ],
            ),
    );
  }

  void _saveData() async {
    final nameStr = _nameController.text;
    final lastNameStr = _lastNameController.text;
    final weightStr = _weightController.text;
    final heightStr = _heightController.text;

    _nameError = null;
    _lastNameError = null;
    _weightError = null;
    _heightError = null;

    final userId = _getUserIdUseCase.invoke();

    if (userId == null) {
      setState(() {});
      return;
    }

    if (nameStr.isEmpty) {
      setState(() {
        _nameError = "El nombre no puede quedar vacío";
      });

      return;
    }

    if (lastNameStr.isEmpty) {
      setState(() {
        _lastNameError = "El nombre no puede quedar vacío";
      });

      return;
    }

    if (weightStr.isEmpty) {
      setState(() {
        _nameError = "El peso no puede quedar vacío";
      });

      return;
    }

    final weight = double.parse(weightStr);

    if (heightStr.isEmpty) {
      setState(() {
        _nameError = "La altura no puede quedar vacío";
      });

      return;
    }

    final height = double.parse(heightStr);

    setState(() {
      _isLoading = true;
    });

    final changes = {
      User.FIELD_FIRST_NAME: nameStr,
      User.FIELD_LAST_NAME: lastNameStr,
      User.FIELD_WEIGHT: weight,
      User.FIELD_HEIGHT: height,
    };

    final isSameData = _user?.firstName == nameStr &&
        _user?.lastName == lastNameStr &&
        _user?.weight == weight &&
        _user?.height == height;

    if (isSameData || await _updateUserUseCase.invoke(userId, changes)) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Datos actualizados");
    } else {
      setState(() {
        _isLoading = true;
      });

      Fluttertoast.showToast(msg: "Error al actualizar los datos");
    }
  }

  void _getUser() async {
    String? userId = _getUserIdUseCase.invoke();

    if (userId == null) {
      Navigator.pop(context);
      return;
    }

    User? user = await _getUserUseCase.invoke(userId);

    if (user == null) {
      Navigator.pop(context);
      return;
    }

    _user = user;

    _nameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _weightController.text = user.weight.toString();
    _heightController.text = user.height.toString();

    setState(() {
      _isLoading = false;
    });
  }
}
