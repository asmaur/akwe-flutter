import 'package:flutter/material.dart';
import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/theme/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black,
        primaryContainer: Colors.grey,
        error: Colors.redAccent,
        onError: Colors.white60,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      //primaryColor: AppColors.appMidGreen;
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: PTextTheme.lightTextTheme,
      listTileTheme: ListTileThemeData(
          iconColor: AppColors.appBlack,
          textColor: Colors.black
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.appDarkGreen,
        indicatorColor: AppColors.appWhite,
        surfaceTintColor: Colors.black,
      ),

  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: PTextTheme.darkTextTheme,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.white,
      onSecondary: Colors.black,
      primaryContainer: Colors.grey,
      error: Colors.deepOrange,//Color(0xFF850404);
      onError: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: AppColors.appDarkGreen,
      indicatorColor: AppColors.appMidGreen,
      surfaceTintColor: Colors.black,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.appWhite,
      textColor: Colors.white,
    ),
  );









}
