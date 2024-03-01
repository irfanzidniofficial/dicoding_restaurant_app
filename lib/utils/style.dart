import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Colors.orange;
const Color grayColor = Color(0XFF909399);

const Color blackColor = Color(0xFF000000);
const Color whiteColor = Color(0xFFFFFFFF);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w700,
  ),
  displayMedium: GoogleFonts.poppins(
    fontSize: 20,
  ),
  displaySmall: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  headlineMedium: GoogleFonts.poppins(
    fontSize: 15,
  ),
  headlineSmall: GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w500,
  ),
  titleLarge: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  ),
  titleMedium: GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  ),
  titleSmall: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w300,
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
  ),
  bodySmall: GoogleFonts.poppins(
    fontSize: 14,
  ),
);
