import 'package:flutter/material.dart';

class ScreenModel {
  final String name;
  final int navKey;
  final MaterialColor colors;
  static const _shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  get shades => _shades;
  ScreenModel({required this.name, required this.colors, required this.navKey});
  Color? getColorByShade(shade) => colors[shade];
}

final screensData = <ScreenModel>[
  ScreenModel(name: 'red', colors: Colors.red, navKey: 1),
  ScreenModel(name: 'green', colors: Colors.green, navKey: 2),
  ScreenModel(name: 'blue', colors: Colors.blue, navKey: 3),
];