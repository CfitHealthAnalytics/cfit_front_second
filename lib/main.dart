import 'package:cfit/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*import 'package:cfit/ui/components/app.dart';*/

import 'package:cfit/constants.dart';
import 'package:cfit/screens/welcome/welcome_screen.dart';
import 'package:cfit/pages/fingerprint_page.dart';

//void main() {
//  runApp(MyApp());
//  }


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static const String title = 'CFit';

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromRGBO(17, 165, 153, 1);
    final primaryColorDark = Color.fromRGBO(17, 165, 153, 1);
    final primaryColorLight = Color.fromRGBO(17, 165, 153, 1);

    return MaterialApp(
      title: 'Cfit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'SF Pro Display',
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
      home: LoginScreen(),
    );
  }
}
