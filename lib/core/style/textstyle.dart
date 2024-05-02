// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/services/local/cach_helper.dart';

class AppTheme {
  static String? primaryColorString = "#4263EB";
  static String? secondaryColorString = "#F5F7FE";
  static late bool isLightTheme;
  static Future<ThemeData> getTheme() async {
    isLightTheme = await CacheHelper.getData(key: 'light') ?? true;

    if (!isLightTheme) {
      return darkTheme();
    } else {
      return lightTheme();
    }
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headlineLarge: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: base.headlineLarge!.color,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      labelSmall: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: base.labelSmall!.color,
          fontSize: 14,
        ),
      ),
      labelMedium: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: base.labelMedium!.color,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      bodyMedium: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: base.bodyMedium!.color,
          fontSize: 16,
        ),
      ),
      bodySmall: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: base.bodySmall!.color,
          fontSize: 14,
        ),
      ),
      titleLarge: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: base.titleLarge!.color,
          fontSize: 16,
        ),
      ),
      bodyLarge: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: base.bodyLarge!.color,
          fontSize: 34,
        ),
      ),
      headlineMedium: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: base.headlineMedium!.color,
          fontSize: 20,
        ),
      ),
      titleMedium: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: base.titleMedium!.color,
          fontSize: 12,
        ),
      ),
      titleSmall: GoogleFonts.manrope(
        textStyle: TextStyle(
          color: base.titleSmall!.color,
          fontSize: 10,
        ),
      ),
    );
  }

  static ThemeData lightTheme() {
    Color primaryColor = HexColor(primaryColorString!);
    Color secondaryColor = HexColor(secondaryColorString!);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );

    final ThemeData base = ThemeData.light();
    return base.copyWith(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      appBarTheme: AppBarTheme(color: Colors.white),
      popupMenuTheme: PopupMenuThemeData(color: Colors.white),
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      hoverColor: Colors.transparent,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      //platform: TargetPlatform.iOS,
      indicatorColor: primaryColor,
            progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor,refreshBackgroundColor: Colors.white),

      disabledColor: HexColor("#D5D7D8"),
    );
  }

  static ThemeData darkTheme() {
    Color primaryColor = HexColor(primaryColorString!);
    Color secondaryColor = HexColor(secondaryColorString!);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      popupMenuTheme: PopupMenuThemeData(color: Colors.black),
      appBarTheme: AppBarTheme(color: Colors.black),
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor,circularTrackColor: Colors.white),
     
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.grey[850],
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
     // platform: TargetPlatform.iOS,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
