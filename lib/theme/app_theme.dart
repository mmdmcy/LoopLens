import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tool desk palette — editor / debugger, not marketing site.
class AppColors {
  static const bg = Color(0xFF12141A);
  static const panel = Color(0xFF1A1D26);
  static const panelEdge = Color(0xFF2A2F3C);
  static const gutter = Color(0xFF0E1015);
  static const text = Color(0xFFE6E8EF);
  static const muted = Color(0xFF8B92A5);
  static const dim = Color(0xFF5C6478);

  static const active = Color(0xFFF0A202); // amber — current line / focus
  static const activeSoft = Color(0x33F0A202);
  static const accent = Color(0xFF3DDC97); // mint — true / body run
  static const accentSoft = Color(0x223DDC97);
  static const danger = Color(0xFFE85D4C); // false / stop
  static const dangerSoft = Color(0x22E85D4C);
  static const info = Color(0xFF6EA8FE);

  static const codeKw = Color(0xFFFF7B72);
  static const codeFn = Color(0xFF79C0FF);
  static const codeNum = Color(0xFF79C0FF);
  static const codeStr = Color(0xFFA5D6FF);
  static const codePlain = Color(0xFFE6EDF3);
}

class AppTheme {
  static ThemeData dark() {
    final base = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.panel,
        primary: AppColors.active,
        secondary: AppColors.accent,
        error: AppColors.danger,
        onSurface: AppColors.text,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.ibmPlexSansTextTheme(base.textTheme).apply(
        bodyColor: AppColors.text,
        displayColor: AppColors.text,
      ),
      dividerColor: AppColors.panelEdge,
      iconTheme: const IconThemeData(color: AppColors.muted, size: 20),
      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: AppColors.gutter,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.panelEdge),
        ),
        textStyle: GoogleFonts.ibmPlexSans(
          color: AppColors.text,
          fontSize: 12,
        ),
      ),
    );
  }

  static TextStyle mono({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double height = 1.45,
  }) {
    return GoogleFonts.ibmPlexMono(
      fontSize: size,
      fontWeight: weight,
      color: color ?? AppColors.codePlain,
      height: height,
    );
  }

  static TextStyle ui({
    double size = 13,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double height = 1.35,
  }) {
    return GoogleFonts.ibmPlexSans(
      fontSize: size,
      fontWeight: weight,
      color: color ?? AppColors.text,
      height: height,
    );
  }
}
