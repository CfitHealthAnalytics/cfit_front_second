import 'package:cfit/data/models/auth.dart';
import 'package:cfit/data/models/user.dart';
import 'package:cfit/data/repository/auth.dart';
import 'package:cfit/data/repository/user.dart';
import 'package:cfit/domain/use_cases/feed_use_case.dart';
import 'package:cfit/domain/use_cases/initialization_use_case.dart';
import 'package:cfit/domain/use_cases/logout_use_case.dart';
import 'package:cfit/domain/use_cases/register_use_case.dart';
import 'package:cfit/external/api/authenticated_client.dart';
import 'package:cfit/external/api/unauthenticated_client.dart';
import 'package:cfit/external/factory/api.dart';
import 'package:cfit/external/storage/storage_client.dart';
import 'package:cfit/util/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/use_cases/login_use_case.dart';
import '../external/models/storage.dart';

extension DependencyInjection on BuildContext {
  UnauthenticatedClient unauthenticatedClient() {
    return UnauthenticatedClient(
      baseUri: AppConstants.BASE_URL,
      factory: ApiResponseFactory(),
    );
  }

  AuthenticatedClient authenticatedClient() {
    return AuthenticatedClient(
        baseUri: AppConstants.BASE_URL,
        factory: ApiResponseFactory(),
        storage: storage());
  }

  Storage storage() {
    return StorageImpl(
      sharedPreferences: SharedPreferences.getInstance(),
    );
  }

  AuthRepository authRepository() {
    return AuthRepositoryImpl(
      client: unauthenticatedClient(),
      storage: storage(),
    );
  }

  UserRepository userRepository() {
    return UserRepositoryImpl(
      client: authenticatedClient(),
      storage: storage(),
    );
  }

  InitializationUseCase initializationUseCase() {
    return InitializationUseCase(
      authRepository: authRepository(),
    );
  }

  LoginUseCase loginUseCase() {
    return LoginUseCase(
      authRepository(),
    );
  }

  RegisterUseCase registerUseCase() {
    return RegisterUseCase(
      authRepository(),
    );
  }

  FeedUseCase feedUseCase() {
    return FeedUseCase(
      userRepository: userRepository(),
    );
  }

  LogoutUseCase logoutUseCase() {
    return LogoutUseCase(
      authRepository(),
    );
  }
}
