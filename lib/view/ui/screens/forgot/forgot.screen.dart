import 'package:cfit/controller/auth_controller.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/presentation/shared/loading/base.widget.dart';
import 'package:cfit/util/Images.dart';
import 'package:cfit/view/ui/screens/forgot/controller/forgot.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cfit/constants.dart';

class ForgotScreen extends GetView<ForgotController> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 30),
              child: Container(
                width: context.width > 700 ? 700 : context.width,
                decoration: context.width > 700
                    ? BoxDecoration(
                        color: Theme.of(context).cardColor,
                      )
                    : null,
                child: GetBuilder<AuthController>(builder: (authController) {
                  return GetBuilder<ForgotController>(
                      builder: (forgotController) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: 160),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  Images.logo_nameLogin,
                                  scale: 6,
                                ),
                              ),
                              const SizedBox(height: kDefaultPadding / 3),
                              const SizedBox(height: 50),
                              TextFormField(
                                onChanged: forgotController.email,
                                textAlign: TextAlign.left,
                                //focusNode: controller.loginFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {},
                                style: const TextStyle(
                                  color: kBackgroundBlack,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: const OutlineInputBorder(),
                                  errorText: forgotController.emailError.value,
                                  hintText: 'E-mail',
                                  hintStyle: Get.textTheme.headline6
                                      ?.copyWith(color: Colors.black54),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  forgotController.forgot();
                                  //controller.enableButton ? controller.doLogin : null
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kPrimaryBottom),
                                ),
                                child: const SizedBox(
                                  height: 60,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'Recuperar senha',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: kDefaultPadding / 2),
                              GestureDetector(
                                onTap: () => {
                                  Get.toNamed(Routes.login),
                                },
                                child: const Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  });
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
