import 'package:cfit/view/ui/screens/login/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginTextFieldWidget extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        onChanged: controller.login,
        textAlign: TextAlign.left,
        focusNode: controller.loginFocus,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          controller.passwordFocus.requestFocus();
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          errorText: controller.loginError.value,
          hintText: 'E-mail',
          label: Text('E-mail'),
          hintStyle: Get.textTheme.headline6?.copyWith(color: Colors.black54),
        ),
      ),
    );
  }
}
