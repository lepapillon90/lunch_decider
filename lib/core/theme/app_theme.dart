import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2377B8); // Updated Blue
  static const Color secondaryColor = Color(0xFFE8F3FF);
  
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Pretendard', // Assuming we'll use Pretendard or system font
  );
}
