import 'package:flutter/material.dart';
import 'package:radio_umsu/common/values/colors.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.white,
  cardColor: AppColors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.black,
    elevation: 0,
  ),
  iconTheme: IconThemeData(color: AppColors.primary),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.black),
    bodyMedium: TextStyle(color: AppColors.black),
    titleLarge: TextStyle(color: AppColors.black),
  ),
  bottomAppBarTheme: BottomAppBarThemeData(
    color: AppColors.white,
    elevation: 8,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.gray500,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.black,
  cardColor: AppColors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.black,
    foregroundColor: AppColors.white,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(color: AppColors.white),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.white),
    bodyMedium: TextStyle(color: AppColors.white),
    titleLarge: TextStyle(color: AppColors.white),
  ),
  bottomAppBarTheme: BottomAppBarThemeData(
    color: AppColors.black, // Background color for bottom app bar
    elevation: 8,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.black,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.gray500,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
);
