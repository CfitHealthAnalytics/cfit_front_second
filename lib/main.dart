import 'dart:async';

import 'package:cfit/util/routes.dart';
import 'package:flutter/material.dart';

import 'generete_route.dart';
import 'theme.dart';

Future<void> main(List<String> arguments) async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: Routes.splash,
      onGenerateRoute: onGenerateRoutes,
    );
  }
}
