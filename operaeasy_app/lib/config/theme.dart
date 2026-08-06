import 'package:flutter/material.dart';

class OperaEasyTheme {
  // Marca — extraída dos SVGs oficiais (logo-operaeasy.svg, app-icon-teal.svg).
  // O guia de vídeo cita azul #2D6BFF, mas os assets reais (ícone do app,
  // favicon, og-image) usam teal. Teal é a cor que aparece na tela; segue ela.
  static const Color primaryBlue = Color(0xFF14B8C6); // Teal da marca
  static const Color primaryNavy = Color(0xFF0A1430); // Navy

  // Semânticas — afastadas do teal (evita confundir com a marca) e
  // aprofundadas para passar WCAG AA (4.5:1) sobre branco — a tela é lida
  // sob luz solar direta.
  static const Color successGreen = Color(0xFF15803D);
  static const Color warningAmber = Color(0xFFA35A06);
  static const Color errorRed = Color(0xFFC62828);

  // Variantes claras — usadas só como fundo de badge, nunca como texto.
  static const Color successTint = Color(0xFFE7F5EC);
  static const Color warningTint = Color(0xFFFCF0E2);
  static const Color errorTint = Color(0xFFFBEAEA);
  static const Color primaryTint = Color(0xFFE1F6F8);

  // Neutrals — viés levemente azulado, derivado do navy da marca
  static const Color neutral50 = Color(0xFFF7F8FC);
  static const Color neutral100 = Color(0xFFEFF1F7);
  static const Color neutral200 = Color(0xFFE2E6F0);
  static const Color neutral400 = Color(0xFF98A0B5);
  static const Color neutral600 = Color(0xFF4A5268);
  static const Color neutral900 = Color(0xFF0F1526);

  // Escala de raio — um sistema só: cards 16, controles 12, pills full
  static const double radiusCard = 16;
  static const double radiusControl = 12;
  static const double radiusPill = 999;

  // Profundidade — sombras tintadas no navy, nunca preto puro
  static List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: primaryNavy.withValues(alpha: 0.06),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: primaryNavy.withValues(alpha: 0.04),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> shadowLifted = [
    BoxShadow(
      color: primaryNavy.withValues(alpha: 0.10),
      blurRadius: 28,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: primaryNavy.withValues(alpha: 0.05),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  // Dark mode
  static const Color darkNeutral50 = Color(0xFFF9FAFB);
  static const Color darkNeutral100 = Color(0xFF1E293B);
  static const Color darkNeutral200 = Color(0xFF334155);
  static const Color darkNeutral400 = Color(0xFF94A3B8);
  static const Color darkNeutral600 = Color(0xFFCBD5E1);
  static const Color darkNeutral900 = Color(0xFFF1F5F9);

  // Typography - Using System Fonts as fallback for SpaceGrotesk + Manrope
  static const String fontDisplay = 'SpaceGrotesk'; // Fallback: Poppins
  static const String fontBody = 'Manrope'; // Fallback: Inter
  static const String fontMono = 'JetBrainsMono'; // Fallback: Courier

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primaryBlue,
        secondary: primaryNavy,
        surface: neutral50,
        error: errorRed,
      ),
      scaffoldBackgroundColor: neutral50,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
          side: const BorderSide(color: neutral200),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusControl),
          ),
          textStyle: const TextStyle(
            fontFamily: fontDisplay,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          side: const BorderSide(color: primaryBlue, width: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusControl),
          ),
          textStyle: const TextStyle(
            fontFamily: fontDisplay,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: neutral100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: neutral200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: neutral200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: neutral100,
        selectedColor: primaryBlue,
        labelStyle: const TextStyle(
          fontFamily: fontBody,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusPill),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: neutral900,
        ),
        displayMedium: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: neutral900,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: neutral900,
        ),
        titleLarge: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: neutral900,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontBody,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: neutral900,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontBody,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: neutral600,
        ),
        bodySmall: TextStyle(
          fontFamily: fontBody,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: neutral400,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primaryBlue,
        secondary: primaryNavy,
        surface: darkNeutral100,
        error: errorRed,
      ),
      scaffoldBackgroundColor: darkNeutral100,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkNeutral200,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
          side: const BorderSide(color: darkNeutral200),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusControl),
          ),
          textStyle: const TextStyle(
            fontFamily: fontDisplay,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          side: const BorderSide(color: primaryBlue, width: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusControl),
          ),
          textStyle: const TextStyle(
            fontFamily: fontDisplay,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkNeutral200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: darkNeutral200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: darkNeutral200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: darkNeutral200,
        selectedColor: primaryBlue,
        labelStyle: const TextStyle(
          fontFamily: fontBody,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusPill),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: darkNeutral900,
        ),
        displayMedium: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: darkNeutral900,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: darkNeutral900,
        ),
        titleLarge: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: darkNeutral900,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontBody,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: darkNeutral900,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontBody,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: darkNeutral400,
        ),
        bodySmall: TextStyle(
          fontFamily: fontBody,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: darkNeutral400,
        ),
      ),
    );
  }
}
