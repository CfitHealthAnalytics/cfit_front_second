import 'package:cfit/data/models/auth.dart';
import 'package:cfit/data/models/user.dart';
import 'package:cfit/domain/models/user.dart';

class InitializationByConectaUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  InitializationByConectaUseCase({
    required this.authRepository,
    required this.userRepository,
  });

  Future<ConectaUser> call({required String token}) async {
    await authRepository.setConnectaToken(token);
    final user = await userRepository.getConectaUserInfo();
    final alreadyExists = await authRepository.verifyAlreadyExistsUser(
      user.preferredUsername,
      user.email,
    );
    if (alreadyExists) {
      final userCFIT = await userRepository.getUserByEmail(user.email);
      await userRepository.setUserInStorage(userCFIT);
      await userRepository.setConectaUser(true);
    }

    return ConectaUser(
      sub: user.sub,
      emailVerified: user.emailVerified,
      email: user.email,
      familyName: user.familyName,
      givenName: user.givenName,
      name: user.name,
      preferredUsername: user.preferredUsername,
      securityLevel: user.securityLevel,
      userType: user.userType,
      alreadyExists: alreadyExists,
    );
  }
}
