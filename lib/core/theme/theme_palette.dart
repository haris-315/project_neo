import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  // Modern Dark Color Palette
  static const Color deepSpace = Color(0xFF121212);
  static const Color cosmicPurple = Color(0xFF6A00F4);
  static const Color nebulaBlue = Color(0xFF00E0FF);
  static const Color stardust = Color(0xFFE0E0E0);
  static const Color blackHole = Color(0xFF000000);
  static const Color supernova = Color(0xFFFFD700);
  static const Color darkMatter = Color(0xFF1E1E1E);
  static const Color eventHorizon = Color(0xFF2A2A2A);

  // Gradients
  static const Gradient cosmicGradient = LinearGradient(
    colors: [cosmicPurple, nebulaBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient subtleGlow = LinearGradient(
    colors: [Colors.transparent, Colors.white12],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Text Styles
  static const TextStyle futuristicTitle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: stardust,
    letterSpacing: 1.2,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: stardust,
    height: 1.5,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: deepSpace,
    primaryColor: cosmicPurple,
    colorScheme: ColorScheme.dark(
      primary: cosmicPurple,
      secondary: nebulaBlue,
      surface: darkMatter,
    ),
    cardTheme: CardTheme(
      color: darkMatter.withValues(alpha: 0.8),
      elevation: 4,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: futuristicTitle,
      iconTheme: IconThemeData(color: stardust),
    ),
    textTheme: TextTheme(
      displayLarge: futuristicTitle,
      bodyLarge: bodyText,
      bodyMedium: bodyText.copyWith(fontSize: 14),
      labelLarge: bodyText.copyWith(
        fontWeight: FontWeight.w500,
        color: blackHole,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: eventHorizon.withValues(alpha: 0.6),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: TextStyle(color: stardust.withValues(alpha: 0.5)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: nebulaBlue, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.redAccent),
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      buttonColor: cosmicPurple,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cosmicPurple,
        foregroundColor: stardust,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        shadowColor: cosmicPurple.withValues(alpha: 0.3),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: nebulaBlue,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: nebulaBlue,
        side: BorderSide(color: nebulaBlue, width: 1.5),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkMatter.withValues(alpha: 0.9),
      selectedItemColor: nebulaBlue,
      unselectedItemColor: stardust.withValues(alpha: 0.6),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedLabelStyle: TextStyle(fontSize: 12),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: darkMatter.withValues(alpha: 0.9),
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: futuristicTitle,
      contentTextStyle: bodyText,
    ),
    dividerTheme: DividerThemeData(
      color: stardust.withValues(alpha: 0.1),
      thickness: 1,
      space: 16,
    ),
  );

  // Custom Glassmorphism Effect
  static BoxDecoration glassmorphism = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withValues(alpha: 0.05),
        Colors.white.withValues(alpha: 0.02),
      ],
    ),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.2),
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ],
  );

  // Custom Blurred Container
  static Widget blurredContainer({required Widget child, double? blurRadius}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurRadius ?? 10,
          sigmaY: blurRadius ?? 10,
        ),
        child: Container(decoration: glassmorphism, child: child),
      ),
    );
  }

  static Widget customInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    VoidCallback? toggleVisibility,
    Function(String)? validate,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: cosmicPurple.withValues(alpha: 0.2),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          return validate!(value!);
        },
        obscureText: obscureText,
        style: bodyText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: nebulaBlue),
          hintText: hintText,
          hintStyle: TextStyle(color: stardust.withValues(alpha: 0.5)),
          filled: true,
          fillColor: eventHorizon.withValues(alpha: 0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: nebulaBlue, width: 1.5),
          ),
          suffix:
              toggleVisibility != null
                  ? InkWell(
                    onTap: toggleVisibility,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child:
                          obscureText
                              ? Icon(
                                Icons.visibility,
                                size: 18,
                                key: ValueKey('visible'),
                              )
                              : Icon(
                                Icons.visibility_off,
                                size: 18,
                                key: ValueKey('hidden'),
                              ),
                    ),
                  )
                  : null,
        ),
      ),
    );
  }

  // Custom Animated Button
  static Widget customAnimatedButton({
    required String text,
    required VoidCallback onPressed,
    bool isPrimary = true,
  }) {
    return AnimatedContainer(
      height: 45,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: isPrimary ? cosmicGradient : null,
        color: isPrimary ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow:
            isPrimary
                ? [
                  BoxShadow(
                    color: cosmicPurple.withValues(alpha: 0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
                : null,
        border: isPrimary ? null : Border.all(color: nebulaBlue, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: bodyText.copyWith(
                fontWeight: FontWeight.w600,
                color: isPrimary ? blackHole : nebulaBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
