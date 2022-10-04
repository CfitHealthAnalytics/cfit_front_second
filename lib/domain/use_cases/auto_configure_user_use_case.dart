import 'package:cfit/data/entity/conecta_user.dart';
import 'package:cfit/data/models/auth.dart';
import 'package:cfit/data/models/user.dart';
import 'package:cfit/external/models/api.dart';

class AutoConfigureUserUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AutoConfigureUserUseCase({
    required this.authRepository,
    required this.userRepository,
  });

  Future<bool> call({
    required String email,
    required String cpf,
  }) async {
    try {
      final user = await userRepository.getUserByEmail(email);

      await userRepository.setUserInStorage(user);
      await userRepository.setConectaUser(true);

      return await userRepository.addConectaUser(
        AddConectaUserRequest(
          hash: cpf,
          email: email,
        ),
      );
    } on NotFoundException catch (_) {
      return false;
    }
  }
}
