import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color whiteColor = Colors.white;
const Color successGreen = Color(0xFF0CB450);
const Color warningYellow = Color(0xFFFFC100);
const Color dangerRed = Color(0xFFFE5960);
const Color primaryColor = Color(0XFF005a74);
const Color accentColor = Color(0XFF377dbf);

const MaterialColor graySwatch = MaterialColor(0XFF000000, {
  50: Color(0xFFF8FAFC),
  100: Color(0xFFF1F5F9),
  200: Color(0xFFE2E8F0),
  300: Color(0xFFCBD5E1),
  400: Color(0xFF6B7B8C),
  500: Color(0xFF00253e),
  600: Color(0xFF002137),
  700: Color(0xFF001a2c),
  800: Color(0xFF041927),
  900: Color(0xFF00111c),
});

ThemeData appTheme(bool isMobile) {
  final double alpha = isMobile != true ? 0 : -6;
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryIconTheme: IconThemeData(
      color: graySwatch.shade600,
      size: 24,
    ),
    iconTheme: IconThemeData(
      color: graySwatch.shade600,
      size: 24,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: whiteColor,
      toolbarHeight: 64,
      titleTextStyle: TextStyle(
        color: graySwatch.shade900,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: graySwatch.shade600,
        size: 24,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: whiteColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: whiteColor,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: whiteColor,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1,
      backgroundColor: whiteColor,
      selectedLabelStyle: TextStyle(
        color: graySwatch.shade900,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        color: graySwatch.shade600,
        fontSize: 16 + alpha,
        fontWeight: FontWeight.w500,
      ),
      unselectedIconTheme: IconThemeData(color: graySwatch.shade600),
      selectedIconTheme: const IconThemeData(color: primaryColor),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: graySwatch.shade900,
      unselectedItemColor: graySwatch.shade600,
    ),
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      surface: whiteColor,
      secondary: accentColor,
      primary: primaryColor,
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: primaryColor,
      textColor: primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => primaryColor,
        ),
      ),
    ),
    scaffoldBackgroundColor: whiteColor,
    secondaryHeaderColor: const Color(0XFF262d31),
    dividerColor: const Color(0XFFE2E8F0),
    dividerTheme: const DividerThemeData(
      color: Color(0XFFE2E8F0),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: graySwatch.shade900,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: graySwatch.shade900,
        fontSize: 16 + alpha,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: graySwatch.shade900,
        fontSize: 14 + alpha,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: graySwatch.shade900,
        fontSize: 20 + alpha,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: graySwatch.shade900,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: graySwatch.shade900,
        fontSize: 16 + alpha,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: TextStyle(
        color: graySwatch.shade900,
        fontSize: 30 + alpha,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: graySwatch.shade900,
        fontSize: 26 + alpha,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: graySwatch.shade900,
        fontSize: 22 + alpha,
        fontWeight: FontWeight.w600,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      weekdayStyle: TextStyle(
        color: graySwatch.shade900,
        fontSize: 20 + alpha,
        fontWeight: FontWeight.w500,
      ),
      dayStyle: TextStyle(
        color: graySwatch.shade900,
        fontSize: 20 + alpha,
        fontWeight: FontWeight.w500,
      ),
      yearStyle: TextStyle(
        color: graySwatch.shade900,
        fontSize: 20 + alpha,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

ThemeData darkTheme(bool isMobile) {
  final double alpha = isMobile != true ? 0 : -6;
  return ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    primaryIconTheme: IconThemeData(
      color: graySwatch.shade200,
      size: 24,
    ),
    iconTheme: IconThemeData(
      color: graySwatch.shade200,
      size: 24,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: graySwatch.shade900,
      toolbarHeight: 64,
      titleTextStyle: TextStyle(
        color: graySwatch.shade50,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: graySwatch.shade300,
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: graySwatch.shade900,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: graySwatch.shade900,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: graySwatch.shade900,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1,
      backgroundColor: graySwatch.shade900,
      selectedLabelStyle: TextStyle(
        color: graySwatch.shade100,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        color: graySwatch.shade100,
        fontSize: 16 + alpha,
        fontWeight: FontWeight.w500,
      ),
      unselectedIconTheme: IconThemeData(color: graySwatch.shade100),
      selectedIconTheme: IconThemeData(color: graySwatch.shade100),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: graySwatch.shade100,
      unselectedItemColor: graySwatch.shade300,
    ),
    primaryColor: primaryColor,
    colorScheme: ColorScheme.dark(
      surface: graySwatch.shade900,
      secondary: accentColor,
      primary: primaryColor,
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: primaryColor,
      textColor: primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => primaryColor,
        ),
      ),
    ),
    scaffoldBackgroundColor: graySwatch.shade900,
    dividerColor: graySwatch.shade600,
    dividerTheme: DividerThemeData(
      color: graySwatch.shade600,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: graySwatch.shade200,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: graySwatch.shade200,
        fontSize: 16 + alpha,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: graySwatch.shade200,
        fontSize: 14 + alpha,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: graySwatch.shade200,
        fontSize: 20 + alpha,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: graySwatch.shade200,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: graySwatch.shade200,
        fontSize: 16 + alpha,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: TextStyle(
        color: graySwatch.shade200,
        fontSize: 30 + alpha,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: graySwatch.shade200,
        fontSize: 26 + alpha,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: graySwatch.shade200,
        fontSize: 22 + alpha,
        fontWeight: FontWeight.w600,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      weekdayStyle: TextStyle(
        color: graySwatch.shade200,
        fontSize: 20 + alpha,
        fontWeight: FontWeight.w500,
      ),
      dayStyle: TextStyle(
        color: graySwatch.shade200,
        fontSize: 20 + alpha,
        fontWeight: FontWeight.w500,
      ),
      yearStyle: TextStyle(
        color: graySwatch.shade200,
        fontSize: 20 + alpha,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
