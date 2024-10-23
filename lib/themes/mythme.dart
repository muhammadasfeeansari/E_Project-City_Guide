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
      // dark theme
       static ThemeData darktheme(BuildContext context) => ThemeData(
        cardColor: Colors.black,
        canvasColor: darkcreamcolor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                lightblueishcolor, // This will set the button color
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white), // For large text
          titleLarge: TextStyle(color: Colors.white), // For smaller text
        ),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 134, 72, 72),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        brightness: Brightness.dark,
      );
      
  static Color creamcolor = const Color(0xfff5f5f5);
  static Color darkcreamcolor = Vx.gray900;
  static Color blueishcolor = const Color(0xff403b58);
  static Color lightblueishcolor = Vx.indigo500;
  static Color primaryColor =
      const Color(0xFF0288D1); // Teal Blue for the theme
  static Color accentColor = const Color(0xFFFFA726);
}
