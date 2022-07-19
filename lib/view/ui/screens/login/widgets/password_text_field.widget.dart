import 'package:cfit/constants.dart';
import 'package:cfit/view/ui/screens/login/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordTextFieldWidget extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        onChanged: controller.password,
        textAlign: TextAlign.left,
        focusNode: controller.passwordFocus,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          controller.passwordFocus.requestFocus();
        },
        style: const TextStyle(
          color: kBackgroundBlack,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(),
          errorText: controller.passwordError.value,
          hintText: 'Senha',
          hintStyle: Get.textTheme.headline6?.copyWith(color: Colors.black54),
        ),
      ),
    );
  }
}
