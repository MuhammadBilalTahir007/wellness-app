import 'package:flutter/material.dart';

class AppColors {
  // Main Background
  static const Color background = Color(0xFF000000);
  static const Color navBarUnSelectedItem = Color(0xFF66667E);
  // Card/Container Backgrounds
  static const Color cardBackground = Color(0xFF1C1C1E);
  static const Color cardDark = Color(0xFF121212);

  // Accents
  static const Color primaryAccent = Color(0xFF00E5FF); // Cyan/Teal
  static const Color secondaryAccent = Color(
    0xFF20B76F,
  ); // Green for active days
  static const Color knobInnerColor = Color(0xFFE2F0EE);
  static const Color currentWeekDivider = Color(0xFF4855DF); // Cyan/Teal
  static const Color nextWeekDivider = Color(0xFF18AA99);

  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.grey;

  // Specific Functional Colors
  static const Color caloriesColor = Color(0xFF00E5FF); // Cyan
  static const Color weightColor = Color(0xFFB0BEC5); // Greyish white
  static const Color hydrationColor = Color(0xFF48A4E5); // Blue

  static const Color selectionCircle = Color(
    0xFF2E7D32,
  ); // Green circle on calendar
  // Mood Colors
  static const Color moodCalm = Color(0xFF6EB9AD); // Teal
  static const Color moodHappy = Color(0xFFF99955); // Orange
  static const Color moodPeaceful = Color(0xFFF28DB3); // Pink
  static const Color moodContent = Color(0xFFC9BBEF); // Purple
}
