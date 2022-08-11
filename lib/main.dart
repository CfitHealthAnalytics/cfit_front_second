import 'dart:async';

import 'package:cfit/util/routes.dart';
import 'package:cfit/view/ui/screens/home/home_route.dart';
import 'package:cfit/view/ui/screens/login/login_route.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_arguments.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_route.dart';
import 'package:cfit/view/ui/screens/register/register_route.dart';
import 'package:cfit/view/ui/screens/splash/splash_route.dart';
import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(17, 165, 153, 1);
const primaryColorDark = Color.fromARGB(255, 24, 105, 99);
const primaryColorLight = Color.fromRGBO(17, 165, 153, 1);

Future<void> main(List<String> arguments) async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
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
    onGenerateRoute: (settings) {
      final arguments = settings.arguments;
      switch (settings.name) {
        case Routes.splash:
          return MaterialPageRoute(builder: (_) => const SplashRoute());
        case Routes.login:
          return MaterialPageRoute(builder: (_) => const LoginRoute());
        case Routes.register:
          return MaterialPageRoute(builder: (_) => const RegisterRoute());
        case Routes.home:
          return MaterialPageRoute(builder: (_) => const HomeRoute());
        case Routes.my_datas:
          final myDatasArguments =
              MyDataArguments.fromJson(arguments as String);
          return MaterialPageRoute(
              builder: (_) => MyDatasRoute(
                    user: myDatasArguments.user,
                  ));
        default:
      }
      return null;
    },
  ));
}
