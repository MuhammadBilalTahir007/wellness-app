import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle get header => GoogleFonts.mulish(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get subHeader => GoogleFonts.mulish(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get body =>
      GoogleFonts.mulish(fontSize: 16, color: AppColors.textPrimary);

  static TextStyle get bodySmall =>
      GoogleFonts.mulish(fontSize: 14, color: AppColors.textPrimary);

  static TextStyle get caption =>
      GoogleFonts.mulish(fontSize: 12, color: AppColors.textPrimary);

  static TextStyle get captionMedium =>
      GoogleFonts.mulish(fontSize: 12, color: Colors.grey);

  static TextStyle get numberBig => GoogleFonts.mulish(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
}
