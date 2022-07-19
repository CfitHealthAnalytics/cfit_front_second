import 'package:cfit/controller/auth_controller.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/presentation/shared/loading/base.widget.dart';
import 'package:cfit/util/Images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './controllers/login.controller.dart';
import 'widgets/login_button.widget.dart';
import 'widgets/login_text_field.widget.dart';
import 'widgets/password_text_field.widget.dart';
import 'package:cfit/constants.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 30),
                child: SizedBox(
                  width: context.width > 500 ? 500 : context.width,
                  /*padding: context.width > 700
                      ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                      : null,*/

                  child: GetBuilder<AuthController>(builder: (authController) {
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
                              LoginTextFieldWidget(),
                              const SizedBox(height: 10),
                              PasswordTextFieldWidget(),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.forgot);
                                },
                                child: const Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: kBackgroundWhite,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              LoginButtonWidget(),
                              const SizedBox(height: kDefaultPadding / 2),
                              GestureDetector(
                                onTap: () => {
                                  Get.toNamed(Routes.cadastro),
                                },
                                child: const Center(
                                  child: Text(
                                    'Cadastre-se',
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
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
