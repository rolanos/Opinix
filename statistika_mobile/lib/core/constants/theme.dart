import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_constants.dart';

class AppTheme {
  static List<BoxShadow> get shadow => [
        const BoxShadow(
          color: AppColors.shadow,
          offset: Offset(0, 4),
        ),
      ];

  static ThemeData getTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      indicatorColor: AppColors.black,
      primaryColor: Colors.black,
      dividerTheme: DividerThemeData(
        color: AppColors.whiteSecondary.withAlpha(75),
        thickness: 0.75,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: AppColors.black,
        onSecondary: AppColors.white,
        error: Color.fromARGB(255, 205, 135, 135),
        onError: Color.fromARGB(255, 205, 135, 135),
        surface: AppColors.white,
        onSurface: AppColors.black,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 24,
        ),
        titleMedium: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 20,
        ),
        titleSmall: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 16,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 18,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 16,
        ),
        bodySmall: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 14,
        ),
        //Мелкие надписи
        labelMedium: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 14,
        ),
        labelSmall: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 12,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedIconTheme: IconThemeData(
          color: AppColors.black,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.black,
        ),
        selectedLabelStyle: TextStyle(
          color: Color(0xFF000000),
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 12,
        ),
        selectedItemColor: Color(0xFF000000),
        unselectedItemColor: Color(0xFF9CA3AF),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding:
            EdgeInsets.symmetric(horizontal: AppConstants.smallPadding),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        hintStyle: TextStyle(
          color: Color(0xFFADAEBC),
          fontSize: 14,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.smallPadding),
            ),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16,
            ),
          ),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.all(AppConstants.smallPadding * 1.5)),
          backgroundColor: const WidgetStatePropertyAll(
            Color(
              0xFF171717,
            ),
          ),
        ),
      ),
    );
  }
}
