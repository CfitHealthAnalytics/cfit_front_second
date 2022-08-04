import 'dart:async';

import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/login/login_route.dart';
import 'package:cfit/view/ui/screens/register/register_route.dart';
import 'package:cfit/view/ui/screens/splash/splash_route.dart';
import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(17, 165, 153, 1);
const primaryColorDark = Color.fromARGB(255, 38, 162, 151);
const primaryColorLight = Color.fromRGBO(17, 165, 153, 1);

Future<void> main(List<String> arguments) async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'SF Pro Display',
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      backgroundColor: primaryColor,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColorLight)),
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
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
    ),
    initialRoute: Routes.splash,
    routes: {
      Routes.splash: (_) => const SplashRoute(),
      Routes.login: (_) => const LoginRoute(),
      Routes.register: (_) => const RegisterRoute(),
      Routes.home: (_) => const RegisterRoute()
    },
  ));
}
