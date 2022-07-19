import 'package:cfit/constants.dart';
import 'package:cfit/view/ui/screens/login/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginButtonWidget extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        controller.doLogin();
        //controller.enableButton ? controller.doLogin : null
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimaryBottom),
      ),
      child: const SizedBox(
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(
            'Entrar',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
