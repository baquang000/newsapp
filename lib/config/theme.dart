import 'package:flutter/material.dart';
import 'package:newsapp/config/colors.dart';

var lightTheme = ThemeData(
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: lightBgColor,
      filled: true,
      enabledBorder: InputBorder.none,
      prefixIconColor: lightLabelColor,
      labelStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          color: lightFontColor,
          fontWeight: FontWeight.w500),
      hintStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          color: lightFontColor,
          fontWeight: FontWeight.w500),
    ),
    colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        surface: lightBgColor,
        onSurface: lightFontColor,
        primaryContainer: lightDivColor,
        onPrimaryContainer: lightFontColor,
        secondaryContainer: lightFontColor,
        primary: lightPrimaryColor),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontFamily: "Poppins",
          fontSize: 24,
          color: lightFontColor,
          fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(
          fontFamily: "Poppins",
          fontSize: 20,
          color: lightFontColor,
          fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          color: lightFontColor,
          fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          color: lightFontColor,
          fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          color: lightFontColor,
          fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          fontFamily: "Poppins",
          fontSize: 13,
          color: lightFontColor,
          fontWeight: FontWeight.w400),
    ));

var darkTheme = ThemeData(
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: darkBgColor,
      filled: true,
      enabledBorder: InputBorder.none,
      prefixIconColor: darkLabelColor,
      labelStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          color: darkFontColor,
          fontWeight: FontWeight.w500),
      hintStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          color: darkFontColor,
          fontWeight: FontWeight.w500),
    ),
    colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        surface: darkBgColor,
        onSurface: darkFontColor,
        primaryContainer: darkDivColor,
        onPrimaryContainer: darkFontColor,
        secondaryContainer: darkFontColor,
        primary: darkPrimaryColor),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontFamily: "Poppins",
          fontSize: 24,
          color: darkFontColor,
          fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(
          fontFamily: "Poppins",
          fontSize: 20,
          color: darkFontColor,
          fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          color: darkFontColor,
          fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          color: lightFontColor,
          fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          color: darkFontColor,
          fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          fontFamily: "Poppins",
          fontSize: 13,
          color: darkFontColor,
          fontWeight: FontWeight.w400),
    ));
