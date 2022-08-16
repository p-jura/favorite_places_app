import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme defoultTextTheme = TextTheme(
  caption: GoogleFonts.kalam(fontWeight: FontWeight.normal, fontSize: 12),
  button: GoogleFonts.kalam(fontWeight: FontWeight.normal, fontSize: 14),
  subtitle1: GoogleFonts.kalam(fontWeight: FontWeight.w400, fontSize: 16),
  subtitle2: GoogleFonts.kalam(fontWeight: FontWeight.normal, fontSize: 14),
  bodyText1: GoogleFonts.kalam(fontWeight: FontWeight.w400, fontSize: 16),
  bodyText2: GoogleFonts.kalam(fontWeight: FontWeight.w400, fontSize: 14),
  headline6: GoogleFonts.kalam(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: const Color(0xFF140b24),
  ),
  headline5: GoogleFonts.kalam(fontWeight: FontWeight.normal, fontSize: 24),
  headline4: GoogleFonts.kalam(fontWeight: FontWeight.w400, fontSize: 34),
  headline3: GoogleFonts.kalam(fontWeight: FontWeight.w400, fontSize: 48),
  headline2: GoogleFonts.kalam(fontWeight: FontWeight.w200, fontSize: 60),
  headline1: GoogleFonts.kalam(fontWeight: FontWeight.w200, fontSize: 96),
);

const LinearGradient defoultGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFEFEBF7),
    Color(0xFFF3F7EB),
  ],
);
const LinearGradient apBarDefoultGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF673AB7),
    Color(0x23140B24),
  ],
);

const ColorScheme defoultColorScheme = ColorScheme.light(
  primary: Color(0xFF673AB7),
  primaryContainer: Color(0xFFe0d7f0),
  onPrimary: Color(0xFFFFFFFF),
  onPrimaryContainer: Color(0xFF140b24),
  secondary: Color(0xFF89B73A),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFe7f0d7),
  onSecondaryContainer: Color(0xFF1b240b),
  background: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF),
);
