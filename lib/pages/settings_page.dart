import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/framework/firebase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/usecases/SignOutUseCase.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/icons.dart';
import 'package:dietari/utils/routes.dart';
import 'package:dietari/utils/strings.dart';
import 'package:dietari/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AuthDataSource _authDataSource = FirebaseAuthDataSource();

  late AuthRepository _authRepository =
      AuthRepository(authDataSource: _authDataSource);

  late SignOutUseCase _signOutUseCase =
      SignOutUseCase(authRepository: _authRepository);

  final _arrowIcon =
      getIcon(AppIcons.arrow_right, color: primaryColor, size: 30);

  final _textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  final _signOutStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(
        textAppBar: settings,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: Text(edit_data, style: _textStyle),
              trailing: _arrowIcon,
              onTap: _edit,
            ),
            ListTile(
              title: Text(text_tems_conditions.capitalize(), style: _textStyle),
              trailing: _arrowIcon,
              onTap: _openTerms,
            ),
            ListTile(
              title:
                  Text(text_privacy_policies.capitalize(), style: _textStyle),
              trailing: _arrowIcon,
              onTap: _openPolicy,
            ),
            ListTile(
              title: Text(signOut.capitalize(), style: _signOutStyle),
              onTap: _signOut,
            )
          ],
        ).toList(),
      ),
    );
  }

  void _signOut() async {
    if (await _signOutUseCase.invoke()) {
      Phoenix.rebirth(context);
    }
  }

  void _edit() {
    Navigator.pushNamed(context, edit_data_route);
  }

  void _openTerms() async {
    if (await canLaunch(terms_and_conditions_url))
      await launch(terms_and_conditions_url);
  }

  void _openPolicy() async {
    if (await canLaunch(privacy_policy_url)) await launch(privacy_policy_url);
  }
}
