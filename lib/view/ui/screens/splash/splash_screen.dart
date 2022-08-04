import 'package:cfit/constants.dart';
import 'package:flutter/material.dart';

import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SplashController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: FutureBuilder(
        future: controller.init(),
        builder: (context, snapshot) {
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Image.asset(
                'assets/images/logo-final-03.png',
                scale: 8,
              ),
            ),
          );
        },
      ),
    );
  }
}
