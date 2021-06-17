import 'package:flutter/material.dart';
import 'package:dietari/utils/strings.dart';

import 'package:dietari/pages/home_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    home_route: (BuildContext context) => HomePage(title: app_name),
  };
}

const home_route = '/';
