import 'dart:async';
import 'package:cfit/constants.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/view/ui/screens/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends GetView<SplashController> {
  final _storage = Get.find<GetStorage>();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (controller.authController.isLoggedIn()) {
        Get.toNamed(Routes.dashboard);
      } else {
        Get.toNamed(Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Image.asset(
            'assets/images/logo-final-03.png',
            scale: 8,
          ),
        ),
      ),
    );
  }
}
