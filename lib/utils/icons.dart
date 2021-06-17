import 'package:flutter/material.dart';

final _icons = <AppIcons, IconData>{
  AppIcons.Add: Icons.add,
};

Icon getIcon(AppIcons name, {Color? color}) {
  if (color == null) {
    return Icon(_icons[name]);
  } else {
    return Icon(_icons[name], color: color);
  }
}

enum AppIcons {
  Add,
}
