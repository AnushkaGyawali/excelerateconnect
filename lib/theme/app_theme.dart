import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF2D5BFF);
  static const Color bg = Color(0xFFF8F9FF);
  static const Color textDark = Color(0xFF1A1D2C);
  static const Color textSoft = Color(0xFF7B7F9E);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: bg,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: textDark),
      titleTextStyle: TextStyle(
        color: textDark,
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
    ),
    fontFamily: 'Inter',
  );
}
