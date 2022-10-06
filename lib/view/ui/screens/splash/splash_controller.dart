import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/auto_configure_user_use_case.dart';
import 'package:cfit/domain/use_cases/initialization_by_conecta_use_case.dart';
import 'package:cfit/domain/use_cases/initialization_use_case.dart';
import 'package:cfit/view/ui/screens/splash/splash_navigation.dart';

class SplashController {
  SplashController({
    this.token,
    this.initialPage,
    required this.navigation,
    required this.initializationUseCase,
    required this.initializationByConectaUseCase,
    required this.autoConfigureUserUseCase,
  });

  final String? token;
  final int? initialPage;
  final SplashNavigation navigation;
  final InitializationUseCase initializationUseCase;
  final InitializationByConectaUseCase initializationByConectaUseCase;
  final AutoConfigureUserUseCase autoConfigureUserUseCase;

  Future<void> initByNormal() async {
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

  Future<ConectaUser?> _conectaConfig() async {
    final conectaUser = await initializationByConectaUseCase(token: token!);
    if (conectaUser.alreadyExists) {
      return null;
    }
    final success = await autoConfigureUserUseCase(
      cpf: conectaUser.preferredUsername,
      email: conectaUser.email,
    );
    if (success) {
      return null;
    }
    return conectaUser;
  }

  Future<void> initByConnect() async {
    try {
      final responses = await Future.wait([
        _conectaConfig(),
        Future.delayed(const Duration(seconds: 3)),
      ]);

      final conectaUser = responses.first as ConectaUser?;
      if (conectaUser == null) {
        navigation.toHome(
          initialTab: initialPage,
        );
      } else {
        navigation.toCompleteLogin(
          conectaUser: conectaUser,
          initialTab: initialPage!,
        );
      }
    } catch (e) {
      navigation.toGenericError();
    }
  }

  Future<void> init() async {
    if (token != null) {
      await initByConnect();
    } else {
      await initByNormal();
    }
  }
}
