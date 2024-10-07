import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class mytheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        cardColor: Colors.white,
        canvasColor: creamcolor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: blueishcolor, // This will set the button color
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      );
  static Color creamcolor = const Color(0xfff5f5f5);
  static Color darkcreamcolor = Vx.gray900;
  static Color blueishcolor = const Color(0xff403b58);
  static Color lightblueishcolor = Vx.indigo500;
  static Color primaryColor =
      const Color(0xFF0288D1); // Teal Blue for the theme
  static Color accentColor = const Color(0xFFFFA726);
}
