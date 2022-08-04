import 'package:cfit/data/models/auth.dart';

class InitializationUseCase {
  final AuthRepository authRepository;

  InitializationUseCase({
    required this.authRepository,
  });

  Future<bool> call() async {
    try {
      await authRepository.getStoredCredentials();
      return true;
    } catch (e) {
      return false;
    }
  }
}
