import 'package:flutter/material.dart';
import 'package:cfit/pages/login_page.dart';
import 'package:cfit/pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromRGBO(17, 165, 153, 1);
    final primaryColorDark = Color.fromRGBO(17, 165, 153, 1);
    final primaryColorLight = Color.fromRGBO(17, 165, 153, 1);

    return MaterialApp(
      title: 'Cfit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor,
          primaryColorDark: primaryColorDark,
          primaryColorLight: primaryColorLight,
          accentColor: primaryColor,
          backgroundColor: Colors.white,
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primaryColor)),
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColorLight)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor)),
              alignLabelWithHint: true),
          buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(primary: primaryColor),
              buttonColor: primaryColor,
              splashColor: primaryColorLight,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
      home: LoginPage(),
    );
  }
}
