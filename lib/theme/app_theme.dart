import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF2D5BFF);
  static const Color bg = Color(0xFFF6F7FB);
  static const Color textDark = Color(0xFF101828);
  static const Color textSoft = Color(0xFF667085);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: bg,
      fontFamily: "SF Pro Display",
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: textDark,
      ),
    );
  }
}
