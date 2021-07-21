import 'package:dietari/pages/base_register_1_page.dart';
import 'package:dietari/pages/base_register_2_page.dart';
import 'package:dietari/pages/base_register_3_page.dart';
import 'package:flutter/material.dart';
import 'package:dietari/utils/strings.dart';
import 'package:dietari/pages/home_page.dart';
import 'package:dietari/pages/login_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    home_route: (BuildContext context) => HomePage(title: app_name),
    login_route: (BuildContext context) => LoginPage(),
    base_register_1_route: (BuildContext context) => BaseRegister1Page(),
    base_register_2_route: (BuildContext context) => BaseRegister2Page(),
    base_register_3_route: (BuildContext context) => BaseRegister3Page(),
  };
}

const home_route = '/';
const login_route = 'login';
const base_register_1_route = 'base_register_1';
const base_register_2_route = 'base_register_2';
const base_register_3_route = 'base_register_3';
