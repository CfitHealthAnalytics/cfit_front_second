import 'package:cfit/data/api/api_client.dart';
import 'package:cfit/presentation/shared/loading/loading.controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForgotController extends GetxController implements GetxService {
  final ApiClient _apiClient;
  final _loadingController = Get.find<LoadingController>();

  ForgotController({required ApiClient apiClient}) : _apiClient = apiClient;

  final _storage = Get.find<GetStorage>();

  final email = ''.obs;
  final emailError = RxnString();
  final emailFocus = FocusNode();

  Future<void> forgot() async {
    print(email.value);
    if (email.value.isNotEmpty) {
      try {
        Response response = await _apiClient.postData(
            '/send_reset_password_email/', {"email": email.value}, '');
        print(response.body);
      } catch (e) {
        print(e);
      }
    } else {
      print('Vazio');
    }
  }
}
