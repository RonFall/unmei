import 'package:flutter/material.dart';

enum AppTheme {
  dark,
  light,
  redDark,
  blueDark,
  greenDark,
}

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueGrey,
    primarySwatch: Colors.blueGrey,
  ),

  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF1E1E1E),
    primarySwatch: Colors.blue,
  ),

  AppTheme.redDark: ThemeData(
    brightness: Brightness.dark,
    indicatorColor: Color(0xFF312121),
    cardColor: Color(0xFF291919),
    backgroundColor: Color(0xFF221212),
    bottomAppBarColor: Color(0xFF2a0b0b),
    highlightColor: Colors.white,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(0xFF3e0808),
    ),
    colorScheme: ColorScheme.dark(
      secondary: Color(0xFF3e0808),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF312121)),
        overlayColor: MaterialStateProperty.all(Color(0xFF291919)),
      ),
    ),
  ),

  AppTheme.greenDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
  ),

  AppTheme.blueDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
  ),
};
