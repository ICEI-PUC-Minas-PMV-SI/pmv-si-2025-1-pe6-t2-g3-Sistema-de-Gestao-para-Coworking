import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart'; // Import the corrected colors

class AppTheme {
  static ThemeData get themeData {
    final baseTheme = ThemeData.light(); // Start with a base light theme

    return baseTheme.copyWith(
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryOrange, // Main interactive color (buttons, etc.)
        secondary: AppColors.darkBlue, // Accent color (cards, maybe headers)
        surface: AppColors.white, // Background for cards, dialogs
        background: AppColors.backgroundBeige, // Main screen background
        error: AppColors.cancelRed,
        onPrimary: AppColors.white, // Text/icons on primary color
        onSecondary: AppColors.white, // Text/icons on secondary color
        onSurface: AppColors.textDark, // Text/icons on surface color
        onBackground: AppColors.textDark, // Text/icons on background color
        onError: AppColors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.backgroundBeige,

      // Typography using Google Fonts (Poppins)
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme).copyWith(
        // Define specific styles if needed, otherwise defaults from Poppins are used
        headlineSmall: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w600, // Semi-bold for titles
          color: AppColors.textDark,
        ),
        titleMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w500, // Medium weight
          color: AppColors.textDark,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: AppColors.textDark,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: AppColors.textGrey, // Use grey for less emphasis
        ),
        bodySmall: GoogleFonts.poppins(
          color: AppColors.textGrey,
          fontSize: 12,
        ),
        labelLarge: GoogleFonts.poppins( // For button text
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white, // White AppBar background
        foregroundColor: AppColors.textDark, // Dark text/icons on AppBar
        elevation: 1, // Subtle shadow
        iconTheme: const IconThemeData(color: AppColors.textDark),
        actionsIconTheme: const IconThemeData(color: AppColors.textDark),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.darkBlue, // Dark blue background for cards
        elevation: 2,
        margin: EdgeInsets.zero, // Remove default margins if needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        clipBehavior: Clip.antiAlias, // Ensures content respects rounded corners
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrange,
          foregroundColor: AppColors.white,
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          minimumSize: const Size(double.infinity, 50), // Default full width
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryOrange,
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryOrange,
          side: const BorderSide(color: AppColors.primaryOrange, width: 1.5),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),

      // Input Decoration Theme (for TextFormFields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        hintStyle: GoogleFonts.poppins(color: AppColors.textGrey.withOpacity(0.8)),
        labelStyle: GoogleFonts.poppins(color: AppColors.textGrey),
        floatingLabelStyle: GoogleFonts.poppins(color: AppColors.primaryOrange), // Label color when focused
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.borderGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.primaryOrange, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.cancelRed, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.cancelRed, width: 1.5),
        ),
        prefixIconColor: AppColors.textGrey,
        // Define error style if needed
        errorStyle: GoogleFonts.poppins(color: AppColors.cancelRed, fontSize: 12),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        titleTextStyle: GoogleFonts.poppins(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: GoogleFonts.poppins(
          color: AppColors.textGrey, // Lighter text for content on dark background
          fontSize: 14,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primaryOrange,
        unselectedItemColor: AppColors.textGrey,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        elevation: 2,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightGrey,
        disabledColor: Colors.grey.shade300,
        selectedColor: AppColors.primaryOrange,
        secondarySelectedColor: AppColors.primaryOrange,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        labelStyle: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 13),
        secondaryLabelStyle: GoogleFonts.poppins(color: AppColors.white, fontSize: 13),
        brightness: Brightness.light,
        shape: StadiumBorder(side: BorderSide(color: AppColors.borderGrey)),
      ),
    );
  }
}

