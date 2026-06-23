import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00A651);
  static const Color primaryDark = Color(0xFF008C44);
  static const Color accent = Color(0xFFFFD700);
  static const Color background = Color(0xFF0A0E17);
  static const Color surface = Color(0xFF141B2D);
  static const Color surfaceLight = Color(0xFF1E2A45);
  static const Color card = Color(0xFF1A2332);
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF8B9CB3);
  static const Color live = Color(0xFFFF3B30);
  static const Color win = Color(0xFF34C759);
  static const Color draw = Color(0xFFFF9500);
  static const Color loss = Color(0xFFFF453A);
  static const Color usa = Color(0xFF3C3B6E);
  static const Color mexico = Color(0xFF006847);
  static const Color canada = Color(0xFFFF0000);

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF00A651), Color(0xFF006847), Color(0xFF3C3B6E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A2332), Color(0xFF141B2D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
