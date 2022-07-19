import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  static void showSuccess(
      {required String message,
      Duration duration = const Duration(seconds: 3)}) {
    Get.rawSnackbar(
      title: 'Success',
      icon: const Icon(Icons.thumb_up, color: Colors.white),
      message: message,
      backgroundColor: Colors.green.shade600,
      duration: duration,
    );
  }

  static void showWarning(
      {required String message,
      Duration duration = const Duration(seconds: 3)}) {
    Get.rawSnackbar(
      title: 'Opps',
      icon: const Icon(Icons.warning, color: Colors.white),
      message: message,
      backgroundColor: Colors.orange.shade900,
      duration: duration,
    );
  }

  static void showError(
      {required String message,
      Duration duration = const Duration(seconds: 3)}) {
    Get.rawSnackbar(
      title: 'Error',
      icon: const Icon(Icons.error, color: Colors.white),
      message: message,
      backgroundColor: Colors.redAccent.shade700,
      duration: duration,
    );
  }
}
