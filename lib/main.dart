import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'package:cfit/helper/responsive_helper.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/get_di.dart' as di;

import 'package:cfit/util/config.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'initializer.dart';

Future<void> main(List<String> arguments) async {
  if (ResponsiveHelper.isMobilePhone()) {
    //HttpOverrides.global = new MyHttpOverrides();
  }

  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();

  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  Map<String, Map<String, String>> _languages = await di.init();

  int _orderID;

  await Initializer.init();
  final initialRoute = await Routes.initialRoute;
  //runApp(Main(initialRoute));

  runApp(MaterialApp(
    /*
    localizationsDelegates: const [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
    ],
    */
    //supportedLocales: const [Locale("pt", "BR")],
    debugShowCheckedModeBanner: false,
    home: Main(initialRoute),
  ));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(17, 165, 153, 1);
    const primaryColorDark = Color.fromARGB(255, 38, 162, 151);
    const primaryColorLight = Color.fromRGBO(17, 165, 153, 1);

    return GetMaterialApp(
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      getPages: Nav.routes,

      translations: Language(brLanguage: BrLanguage()),
      locale: const Locale('en', 'EN'),

      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        backgroundColor: Colors.white,
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
      //w: const [Locale('pt', 'BR'), Locale('en')],

      //supportedLocales: const [Locale('en'), Locale('fr')],
    );
  }
}

class Language extends Translations {
  final BaseLanguage brLanguage;

  Language({required this.brLanguage});

  @override
  Map<String, Map<String, String>> get keys => {
        'pt_BR': brLanguage.language,
      };
}

abstract class BaseLanguage {
  Map<String, String> get language;
}

class BrLanguage implements BaseLanguage {
  @override
  Map<String, String> get language => {'test': 'English Language Translation'};
}

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  const EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    final env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.production
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.homolog ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}
