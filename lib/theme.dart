import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(17, 165, 153, 1);
const primaryColorDark = Color.fromARGB(255, 24, 105, 99);
const primaryColorLight = Color.fromRGBO(17, 165, 153, 1);

final theme = ThemeData(
  fontFamily: 'Rubik',
  primaryColor: primaryColor,
  primaryColorDark: primaryColorDark,
  primaryColorLight: primaryColorLight,
  backgroundColor: primaryColor,
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: primaryColor,
      fontFamily: 'Rubik',
    ),
    headline2: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryColor,
        fontFamily: 'Rubik'),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: primaryColorLight)),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
    alignLabelWithHint: true,
  ),
  buttonTheme: ButtonThemeData(
    colorScheme: const ColorScheme.light(primary: primaryColor),
    buttonColor: primaryColor,
    splashColor: primaryColorLight,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
    if (states.contains(MaterialState.selected)) {
      return primaryColor;
    }
    return Colors.black;
  })),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
);
