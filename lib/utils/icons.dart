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
  AppIcons.clock: Icons.query_builder,
  AppIcons.error: Icons.error_outline,
  AppIcons.settings: Icons.settings_outlined,
  AppIcons.arrow_right: Icons.keyboard_arrow_right,
};

Icon getIcon(AppIcons name, {Color? color, double? size}) {
  return Icon(
    _icons[name],
    color: color,
    size: size,
  );
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
  clock,
  error,
  settings,
  arrow_right,
}
