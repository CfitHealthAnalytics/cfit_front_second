import 'package:cfit/controller/user_controller.dart';
import 'package:cfit/infrastructure/navigation/bindings/domains/auth.repository.binding.dart';
import 'package:cfit/view/ui/screens/MyMeasures/controllers/mymeasures.controller.dart';
//import 'package:cfit/pages/usuarios_page_controller.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:cfit/view/ui/screens/forgot/controller/forgot.controller.dart';
import 'package:cfit/view/ui/screens/home/controllers/home.controller.dart';
import 'package:cfit/view/ui/screens/maps/location_controller.dart';
import 'package:cfit/view/ui/screens/perfil/controller/perfil.controller.dart';
import 'package:cfit/view/ui/screens/place/MapsController.dart';
import 'package:cfit/view/ui/screens/qr_code/controller/qr_code.controller.dart';
import 'package:cfit/view/ui/screens/register/controllers/register.controller.dart';
import 'package:cfit/view/ui/screens/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:cfit/view/ui/screens/login/controllers/login.controller.dart';

class DependenciesControllerBinding extends Bindings {
  @override
  void dependencies() {
    final authRepositoryBinding = AuthRepositoryBinding();

    Get.lazyPut<HomeController>(
      () => HomeController(authRepository: authRepositoryBinding.repository),
    );

    Get.lazyPut<EventsController>(
      () => EventsController(
          authRepository: authRepositoryBinding.authController),
    );

    Get.lazyPut<LoginController>(
      () => LoginController(authRepository: authRepositoryBinding.repository),
    );

    Get.lazyPut<RegisterController>(
      () =>
          RegisterController(authRepository: authRepositoryBinding.repository),
    );

    Get.lazyPut<MapsController>(
      () => MapsController(),
    );

    Get.lazyPut<PerfilController>(
      () => PerfilController(authRepository: authRepositoryBinding.repository),
    );

    Get.lazyPut<SplashController>(
      () => SplashController(
          authRepository: authRepositoryBinding.authController),
    );

    Get.lazyPut<MyMeasuresController>(
      () => MyMeasuresController(
          authRepository: authRepositoryBinding.repository),
    );

    Get.lazyPut<LocationController>(
      () =>
          LocationController(authRepository: authRepositoryBinding.repository),
    );
    Get.lazyPut<ForgotController>(
      () => ForgotController(apiClient: authRepositoryBinding.apiClient),
    );
    Get.lazyPut<QrCodeController>(
      () => QrCodeController(),
    );

    Get.lazyPut<UserController>(
      () => UserController(userRepo: authRepositoryBinding.userRepo),
    );

    /*
    Get.lazyPut<UsuarioController>(
      () => UsuarioController(authRepository: authRepositoryBinding.repository),
    );
    */
  }
}
