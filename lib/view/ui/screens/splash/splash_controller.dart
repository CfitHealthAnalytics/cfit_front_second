import 'package:cfit/domain/use_cases/initialization_use_case.dart';
import 'package:cfit/view/ui/screens/splash/splash_navigation.dart';

class SplashController {
  SplashController({
    required this.initializationUseCase,
    required this.navigation,
  });
  final SplashNavigation navigation;
  final InitializationUseCase initializationUseCase;

  Future<void> init() async {
    final responses = await Future.wait([
      initializationUseCase(),
      Future.delayed(const Duration(seconds: 3)),
    ]);
    final ready = responses.first;
    if (ready) {
      navigation.toHome();
    } else {
      navigation.toLogin();
    }
  }
}
