import 'package:flutter/material.dart';
import 'package:dietari/utils/strings.dart';
import 'package:dietari/pages/home_page.dart';
import 'package:dietari/pages/Login.dart';
import 'package:dietari/pages/Base_Register_Screen_1.dart';
import 'package:dietari/pages/Base_Register_Screen_2.dart';
import 'package:dietari/pages/Base_Register_Screen_3.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    home_route: (BuildContext context) => HomePage(title: app_name),
    login_route: (BuildContext context) => Login(),
    base_register_screen_1_route: (BuildContext context) => Base_Register_1(),
    base_register_screen_2_route: (BuildContext context) => Base_Register_2(),
    base_register_screen_3_route: (BuildContext context) => Base_Register_3(),
  };
}

const home_route = '/';
const login_route = 'login';
const base_register_screen_1_route = 'base_register_1';
const base_register_screen_2_route = 'base_register_2';
const base_register_screen_3_route = 'base_register_3';
