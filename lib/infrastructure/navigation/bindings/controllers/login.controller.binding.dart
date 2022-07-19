import 'package:cfit/infrastructure/navigation/bindings/domains/auth.repository.binding.dart';
import 'package:get/get.dart';
import 'package:cfit/view/ui/screens/login/controllers/login.controller.dart';

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    final authRepositoryBinding = AuthRepositoryBinding();

    Get.lazyPut<LoginController>(
      () => LoginController(authRepository: authRepositoryBinding.repository),
    );
  }
}
