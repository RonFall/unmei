import 'package:flutter/material.dart';

enum AppTheme {
  light,
  dark,
  redDark,
  blueDark,
  greenDark,
}

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    indicatorColor: Color(0xFFfefefe),
    cardColor: Color(0xFFf1f1f1),
    backgroundColor: Color(0xFFe0e0e0),
    bottomAppBarColor: Color(0xFFd0d0d0),
    highlightColor: Colors.black,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(0xffcbcbcb),
    ),
    colorScheme: ColorScheme.light(
      secondary: Color(0xFFcbcbcb),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFFfefefe)),
        overlayColor: MaterialStateProperty.all(Color(0xFFf1f1f1)),
      ),
    ),
  ),

  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    indicatorColor: Color(0xFF212121),
    cardColor: Color(0xFF191919),
    backgroundColor: Color(0xFF121212),
    bottomAppBarColor: Color(0xFF0b0b0b),
    highlightColor: Colors.white,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(0xff383838),
    ),
    colorScheme: ColorScheme.dark(
      secondary: Color(0xFF383838),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF212121)),
        overlayColor: MaterialStateProperty.all(Color(0xFF191919)),
      ),
    ),
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
    indicatorColor: Color(0xFF213121),
    cardColor: Color(0xFF192919),
    backgroundColor: Color(0xFF122212),
    bottomAppBarColor: Color(0xFF0b2a0b),
    highlightColor: Colors.white,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(0xff0f3e08),
    ),
    colorScheme: ColorScheme.dark(
      secondary: Color(0xFF0f3e08),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF213121)),
        overlayColor: MaterialStateProperty.all(Color(0xFF192919)),
      ),
    ),
  ),

  AppTheme.blueDark: ThemeData(
    brightness: Brightness.dark,
    indicatorColor: Color(0xFF212131),
    cardColor: Color(0xFF191929),
    backgroundColor: Color(0xFF121222),
    bottomAppBarColor: Color(0xFF0b0b1a),
    highlightColor: Colors.white,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(0xff080f3e),
    ),
    colorScheme: ColorScheme.dark(
      secondary: Color(0xFF080f3e),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF212131)),
        overlayColor: MaterialStateProperty.all(Color(0xFF191929)),
      ),
    ),
  ),
};