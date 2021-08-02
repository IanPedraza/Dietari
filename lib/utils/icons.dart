import 'package:flutter/material.dart';

final _icons = <AppIcons, IconData>{
  AppIcons.add: Icons.add,
  AppIcons.visibility_off: Icons.visibility_off,
  AppIcons.visibility: Icons.visibility,
  AppIcons.open: Icons.open_in_new,
};

Icon getIcon(AppIcons name, {Color? color}) {
  if (color == null) {
    return Icon(_icons[name]);
  } else {
    return Icon(_icons[name], color: color);
  }
}

enum AppIcons { add, visibility_off, visibility,open }
