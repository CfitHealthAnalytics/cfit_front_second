import 'package:cfit/data/models/auth.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(
    this._authRepository,
  );

  Future<void> call() async {
    await _authRepository.logout();
  }
}
