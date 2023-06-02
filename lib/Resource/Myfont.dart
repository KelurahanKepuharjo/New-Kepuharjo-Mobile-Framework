import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFont {
  static const String defaultFontFamily = 'Poppins';

  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final String fontFamily;

  const MyFont({
    required this.fontSize,
    required this.color,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = defaultFontFamily,
  });

  TextStyle get textStyle => GoogleFonts.getFont(
        fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );

  static TextStyle poppins({
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle inter({
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle montserrat({
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
