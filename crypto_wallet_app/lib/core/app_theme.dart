import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF181A20),
      cardColor: const Color(0xFF23242A),
      primaryColor: const Color(0xFFFF9900), // Laranja Bitcoin
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFF9900),
        secondary: Color(0xFF1F222A),
        background: Color(0xFF181A20),
        surface: Color(0xFF23242A),
        error: Color(0xFFD32F2F),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
        displaySmall: TextStyle(fontSize: 14, color: Colors.white60),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF23242A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }
}
