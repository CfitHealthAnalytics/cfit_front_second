import 'package:cfit/infrastructure/navigation/bindings/domains/auth.repository.binding.dart';
import 'package:cfit/view/ui/screens/events/controller/events.controller.dart';
import 'package:get/get.dart';

class EventsControllerBinding extends Bindings {
  @override
  void dependencies() {
    final authRepositoryBinding = AuthRepositoryBinding();

    Get.lazyPut<EventsController>(
      () => EventsController(
          authRepository: authRepositoryBinding.authController),
    );
  }
}
