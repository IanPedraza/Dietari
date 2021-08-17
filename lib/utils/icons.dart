import 'package:flutter/material.dart';

final _icons = <AppIcons, IconData>{
  AppIcons.add: Icons.add,
  AppIcons.visibility_off: Icons.visibility_off,
  AppIcons.visibility: Icons.visibility,
  AppIcons.open: Icons.open_in_new,
  AppIcons.light: Icons.lightbulb_outline_sharp,
  AppIcons.arrow_back: Icons.arrow_back_ios_outlined,
  AppIcons.check: Icons.check_circle,
  AppIcons.uncheck: Icons.radio_button_unchecked,
  AppIcons.clock: Icons.query_builder
};

Icon getIcon(AppIcons name, {Color? color}) {
  if (color == null) {
    return Icon(_icons[name]);
  } else {
    return Icon(_icons[name], color: color);
  }
}

enum AppIcons {
  add,
  visibility_off,
  visibility,
  arrow_back,
  check,
  uncheck,
  light,
  open,
  clock
}
