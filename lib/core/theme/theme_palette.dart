import 'package:flutter/material.dart';

class AppTheme {
  // Common Colors
  static const Color primaryColor = Colors.blueAccent;
  static const Color secondaryColor = Colors.white70;
  static const Color backgroundColor = Colors.black;
  static const Color cardColor = Color(0xFF1E1E1E);
  static const Color transparentWhite = Colors.white10;

  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [Colors.blueAccent, Colors.lightBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    cardColor: cardColor.withValues(alpha: 0.6),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor.withValues(alpha: 0.7),
      elevation: 0,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: transparentWhite,
      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    iconTheme: const IconThemeData(color: secondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundColor.withValues(alpha: 0.9),
      selectedItemColor: primaryColor,
      unselectedItemColor: secondaryColor,
    ),
  );

}